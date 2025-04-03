import 'package:elegant_spring_animation/elegant_spring_animation.dart';
import 'package:flutter/material.dart';
import 'package:linzen/ui/home/viewmodel/deck_viewmodel.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../shared/components/bottom_sheet.dart';
import '../../shared/components/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.viewModel});

  final DeckViewModel viewModel;

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
                  // Row(
                  //   spacing: 16,
                  //   children: [
                  //     Expanded(
                  //       child: _InfoCard(value: '7', title: 'Day Streak'),
                  //     ),
                  //     Expanded(
                  //       child: _InfoCard(value: '10', title: 'Words learned'),
                  //     ),
                  //   ],
                  // ),
                  Builder(
                    builder: (context) {
                      return _CreateButtonCard(
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
                              return PrimaryButton(
                                onPressed: () {},
                                size: ButtonSize.large,
                                fullWidth: true,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  // StartSessionCard(),
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
                listenable: viewModel,
                builder: (context, child) {
                  return SliverList.separated(
                    itemCount: viewModel.decks.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16);
                    },
                    itemBuilder: (context, index) {
                      return _DeckCard(
                        title: viewModel.decks[index].name,
                        subtitle: 'not implemented',
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

class _CreateButtonCard extends StatelessWidget {
  const _CreateButtonCard({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Create Deck',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          ),
          TextButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              ),
              foregroundColor: WidgetStateProperty.all(Color(0xFF2E333A)),
              textStyle: WidgetStateProperty.all(
                TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              backgroundColor: WidgetStateProperty.all(Color(0xFFEAEBEF)),
            ),
            child: Row(
              spacing: 6,
              children: [
                Text('Create'),
                Icon(Icons.add, size: 20, color: Color(0xFF2E333A)),
              ],
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
            child: PrimaryButton(onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
