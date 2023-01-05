import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomSheetPage extends StatelessWidget {
  final int? modalIndex;

  const BottomSheetPage({
    this.modalIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/?index=1'),
              child: const Text('1'),
            ),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/?index=2'),
              child: const Text('2'),
            ),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/?index=3'),
              child: const Text('3'),
            ),
          ],
        ),
      ),
      bottomSheet: modalIndex == null
          ? null
          : Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              height: 400,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Modal'),
                  leading: modalIndex! == 1
                      ? null
                      : BackButton(
                          onPressed: () => GoRouter.of(context)
                              .go('/?index=${modalIndex! - 1}'),
                        ),
                  actions: [
                    IconButton(
                      onPressed: () => GoRouter.of(context).go('/'),
                      icon: const Icon(
                        Icons.close,
                      ),
                    )
                  ],
                ),
                body: ModalContent(index: modalIndex!),
              ),
            ),
    );
  }
}

class ModalContent extends StatefulWidget {
  final int index;

  const ModalContent({
    required this.index,
    super.key,
  });

  @override
  State<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  final _controller = PageController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _controller.jumpToPage(widget.index - 1));
  }

  @override
  void didUpdateWidget(covariant ModalContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    _controller.animateToPage(
      widget.index - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _controller,
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '1',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              ElevatedButton.icon(
                onPressed: () => GoRouter.of(context).go('/?index=2'),
                icon: const Icon(Icons.arrow_right),
                label: const Text('Next'),
              ),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '2',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              ElevatedButton.icon(
                onPressed: () => GoRouter.of(context).go('/?index=3'),
                icon: const Icon(Icons.arrow_right),
                label: const Text('Next'),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            '3',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ],
    );
  }
}
