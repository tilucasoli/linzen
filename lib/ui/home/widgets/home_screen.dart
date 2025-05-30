import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:linzen/ui/home/viewmodel/deck_viewmodel.dart';
import 'package:linzen/ui/shared/components/create_button_card.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../alert/alert_viewmodel.dart';
import '../../shared/components/bottom_sheet.dart';
import '../../shared/components/button.dart';
import '../../shared/components/slidable_action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.viewModel,
    required this.alertViewModel,
  });

  final DeckViewModel viewModel;
  final AlertViewModel alertViewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.fetchDecks.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        minimum: EdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(top: 16, bottom: 24),
              sliver: SliverToBoxAdapter(child: _Header()),
            ),
            SliverToBoxAdapter(
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: _InfoCard(value: '7', title: 'Day Streak'),
                      ),
                      Expanded(
                        child: _InfoCard(value: '10', title: 'Words learned'),
                      ),
                    ],
                  ),
                  _CreateDeck(
                    viewModel: widget.viewModel,
                    alertViewModel: widget.alertViewModel,
                  ),
                  StartSessionCard(),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 32, bottom: 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Your Decks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    color: Color(0xFF0F172A),
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 32),
              sliver: ListenableBuilder(
                listenable: widget.viewModel,
                builder: (context, child) {
                  return SliverList.separated(
                    itemCount: widget.viewModel.decks.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16);
                    },
                    itemBuilder: (context, index) {
                      return Slidable(
                        key: Key(widget.viewModel.decks[index].id),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            _RenameSlidableButton(
                              viewModel: widget.viewModel,
                              alertViewModel: widget.alertViewModel,
                              index: index,
                            ),
                            _DeletionSlidableButton(
                              viewModel: widget.viewModel,
                              index: index,
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: _DeckCard(
                            title: widget.viewModel.decks[index].name,
                            subtitle: 'not implemented',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFEAEBEF),
    );
  }
}

class _RenameSlidableButton extends StatefulWidget {
  const _RenameSlidableButton({
    required this.viewModel,
    required this.alertViewModel,
    required this.index,
  });

  final DeckViewModel viewModel;
  final AlertViewModel alertViewModel;
  final int index;

  @override
  State<_RenameSlidableButton> createState() => _RenameSlidableButtonState();
}

class _RenameSlidableButtonState extends State<_RenameSlidableButton> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.viewModel.decks[widget.index].name;
  }

  @override
  Widget build(BuildContext context) {
    return SlidableActionButton(
      icon: LucideIcons.pencil,
      onPressed: () {
        showLinzenBottomSheet(
          context,
          title: 'Rename Deck',
          contentBuilder: (context) {
            return Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'New Deck Name',
                  ),
                ),
                Text(
                  'This is the name that will be used to describe the deck.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
              ],
            );
          },
          buttonBuilder: (context) {
            return LinzenButton(
              onPressed: () async {
                final command = widget.viewModel.updateDeck;
                await command.execute(
                  widget.viewModel.decks[widget.index].id,
                  _controller.text,
                );

                if (!context.mounted) return;

                if (command.isFailure) {
                  widget.alertViewModel.show('Failed to rename deck');
                  return;
                }

                if (command.isSuccess) {
                  Navigator.pop(context);
                }
              },
              size: ButtonSize.large,
              fullWidth: true,
              text: 'Save',
            );
          },
        );
      },
      backgroundColor: Color(0xFF2590F2),
      padding: EdgeInsets.only(left: 8),
    );
  }
}

class _DeletionSlidableButton extends StatelessWidget {
  const _DeletionSlidableButton({required this.viewModel, required this.index});

  final DeckViewModel viewModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SlidableActionButton(
      icon: LucideIcons.trash2,
      onPressed: () {
        showLinzenBottomSheet(
          context,
          title: 'Confirm Deletion',
          contentBuilder: (context) {
            return Column(
              spacing: 8,
              children: [
                TextField(
                  enabled: false,
                  controller: TextEditingController(
                    text: viewModel.decks[index].name,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Deck Name',
                  ),
                ),
                Text(
                  'This deck and all its cards will be deleted. Are you sure you want to do that?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            );
          },
          buttonBuilder: (BuildContext context) {
            return LinzenButton(
              fullWidth: true,
              type: ButtonType.destructive,
              size: ButtonSize.large,
              onPressed: () {
                viewModel.deleteDeck.execute(viewModel.decks[index].id);
                Navigator.pop(context);
              },
              text: 'Delete',
            );
          },
        );
      },
      backgroundColor: Color(0xFFEC375A),
      padding: EdgeInsets.only(left: 8),
    );
  }
}

class _CreateDeck extends StatefulWidget {
  const _CreateDeck({required this.viewModel, required this.alertViewModel});

  final DeckViewModel viewModel;
  final AlertViewModel alertViewModel;

  @override
  State<_CreateDeck> createState() => _CreateDeckState();
}

class _CreateDeckState extends State<_CreateDeck> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CreateButtonCard(
      title: 'Create Deck',
      onPressed: () {
        showLinzenBottomSheet(
          context,
          title: 'Create Deck',
          contentBuilder: (context) {
            return Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Deck Name',
                  ),
                ),
                Text(
                  'This is the name that will be used to describe the deck',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
              ],
            );
          },
          buttonBuilder: (context) {
            return LinzenButton(
              onPressed: () async {
                final command = widget.viewModel.createDeck;
                await command.execute(_controller.text);

                if (!context.mounted) return;

                if (command.isFailure) {
                  widget.alertViewModel.show('Failed to create deck');
                  return;
                }

                if (command.isSuccess) {
                  _controller.clear();
                  Navigator.pop(context);
                  return;
                }
              },

              size: ButtonSize.large,
              fullWidth: true,
              text: 'Create',
            );
          },
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.value, required this.title});

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeckCard extends StatelessWidget {
  const _DeckCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          Text(
            'Welcome back 👋',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
              height: 1.1,
            ),
          ),
          Text(
            'What do you want to do today?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class StartSessionCard extends StatelessWidget {
  const StartSessionCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Start a Session',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
              height: 1.5,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'You have 20 cards ready for review across all your decks',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: Color(0xFF64748B),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: LinzenButton(onPressed: () {}, text: 'Start Session'),
          ),
        ],
      ),
    );
  }
}
