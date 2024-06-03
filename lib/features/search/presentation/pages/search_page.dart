import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ir/core/enums/search_type.dart';
import 'package:ir/core/style/theme.dart';
import 'package:ir/core/widgets/app_error.dart';
import 'package:ir/core/widgets/loading_widget.dart';
import 'package:ir/features/search/domain/entities/doc_entity.dart';
import 'package:ir/features/search/presentation/bloc/search_cubit.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/enums/dataset.dart';
import '../../../../core/style/assets/assets.gen.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/introPage';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool openedDataSetsMenu = false;
  bool openedSuggestionMenu = false;
  int selectedDateSet = 0;
  SearchType selectedSearchType = SearchType.normal;
  List<Dataset> dataSets = [Dataset.quora, Dataset.clinical];
  List<SearchType> searchTypes = [
    SearchType.normal,
    SearchType.vectorStore,
    SearchType.clustering,
    SearchType.wordEmbedding
  ];
  List<String> queries = [];
  List<DocEntity> documents = [];
  Curve curve = Curves.linear;
  TextEditingController searchController = TextEditingController();
  String? autoCorrect;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit,SearchState>(
      listener: (context, state){
        if(state is QuerySuggestionSuccessState && state.querySuggestionEntity.queries.isNotEmpty){
          setState(() {
            openedSuggestionMenu = true;
            queries.clear();
            queries.addAll(state.querySuggestionEntity.queries);
          });
        }
        if(state is SearchSuccessState){
          setState(() {
            documents.clear();
            documents.addAll(state.searchResultEntity.data);
            autoCorrect = state.searchResultEntity.autoCorrect;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: ListView(
          children: [
            AnimatedContainer(
              clipBehavior: Clip.hardEdge,
              duration: const Duration(milliseconds: 500),
              curve: openedDataSetsMenu ? Curves.easeOutBack : curve,
              height: openedDataSetsMenu ? 200 : 56,
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Theme.of(context).own().surfaceContainerHigh,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Wrap(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (openedDataSetsMenu) {
                                    curve = Curves.easeOutBack;
                                  }
                                  openedDataSetsMenu = !openedDataSetsMenu;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: openedDataSetsMenu ? 24 : 32,
                                height: openedDataSetsMenu ? 24 : 32,
                                curve: Curves.linear,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: openedDataSetsMenu
                                      ? Theme.of(context)
                                          .own()
                                          .surfaceContainerHigh
                                      : Theme.of(context).colorScheme.primary,
                                ),
                                alignment: Alignment.center,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: openedDataSetsMenu
                                      ? Icon(
                                          Icons.arrow_back,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        )
                                      : Text(
                                          dataSets[selectedDateSet].toChar(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w800,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                        ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                onSubmitted: (String value) {
                                  setState(() {
                                    openedSuggestionMenu = false;
                                    if(value.isNotEmpty) {
                                      context.read<SearchCubit>().search(value, dataSets[selectedDateSet].toJson(), selectedSearchType.toJson());
                                    }
                                  });
                                },
                                onChanged: (String value) {
                                  if (value.isNotEmpty) {
                                    setState(
                                      () {
                                        curve = Curves.bounceOut;
                                        openedDataSetsMenu = false;

                                        context.read<SearchCubit>().getQuerySuggestion(value, dataSets[selectedDateSet].toJson());
                                      },
                                    );
                                  } else {
                                    setState(() {
                                      openedSuggestionMenu = false;
                                    });
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 4),
                              child: InkWell(
                                onTap: () {
                                  if(searchController.text.isNotEmpty) {
                                    context.read<SearchCubit>().search(searchController.text.trim(), dataSets[selectedDateSet].toJson(), selectedSearchType.toJson());
                                  }
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: Icon(
                                Icons.more_vert,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                              color: Theme.of(context).colorScheme.surface,
                              surfaceTintColor: Colors.transparent,
                              itemBuilder: (context) => List.generate(
                                searchTypes.length,
                                (index) {
                                  return PopupMenuItem(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          searchTypes[index].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface),
                                        ),
                                        Visibility(
                                          visible: searchTypes[index] ==
                                              selectedSearchType,
                                          child: Icon(
                                            Icons.check,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: () async {
                                      setState(() {
                                        selectedSearchType = searchTypes[index];
                                        if(searchController.text.isNotEmpty) {
                                          context.read<SearchCubit>().search(searchController.text.trim(), dataSets[selectedDateSet].toJson(), selectedSearchType.toJson());
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Divider(
                            height: 1,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              if(selectedDateSet !=0) {
                                setState(() {
                                  curve = Curves.easeInOutBack;
                                  selectedDateSet = 0;
                                  openedDataSetsMenu = false;
                                });
                                if(searchController.text.isNotEmpty) {
                                  context.read<SearchCubit>().search(
                                    searchController.text.trim(),
                                    dataSets[selectedDateSet].toJson(),
                                    selectedSearchType.toJson());
                                }
                              }
                              else{
                                setState(() {
                                  curve = Curves.easeInOutBack;
                                  openedDataSetsMenu = false;
                                });
                              }
                            },
                            child: Container(
                              color: Theme.of(context).own().surfaceContainerHigh,
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      dataSets[0].toChar(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    dataSets[0].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            indent: 24,
                            endIndent: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              if(selectedDateSet !=1) {
                                setState(() {
                                  curve = Curves.easeInOutBack;
                                  selectedDateSet = 1;
                                  openedDataSetsMenu = false;
                                });
                                if(searchController.text.isNotEmpty) {
                                  context.read<SearchCubit>().search(
                                    searchController.text.trim(),
                                    dataSets[selectedDateSet].toJson(),
                                    selectedSearchType.toJson());
                                }
                              }
                              else{
                                setState(() {
                                  curve = Curves.easeInOutBack;
                                  openedDataSetsMenu = false;
                                });
                              }
                            },
                            child: Container(
                              color: Theme.of(context).own().surfaceContainerHigh,
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      dataSets[1].toChar(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    dataSets[1].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutQuart,
              child: Visibility(
                visible: openedSuggestionMenu,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: MediaQuery.sizeOf(context).width,
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).own().surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Wrap(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: queries.length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 18,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    searchController.text = queries[index];
                                    openedSuggestionMenu = false;
                                    if(searchController.text.isNotEmpty) {
                                      context.read<SearchCubit>().search(searchController.text, dataSets[selectedDateSet].toJson(), selectedSearchType.toJson());
                                    }
                                  },
                                  child: Text(queries[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color:
                                                Theme.of(context).colorScheme.outline,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 12,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if(autoCorrect!=null)Padding(
              padding:
                  const EdgeInsetsDirectional.only(top: 4, start: 32, end: 24),
              child: Row(
                children: [
                  Text(
                    "Do you mean: ",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                  Text(
                    autoCorrect!,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
           BlocBuilder<SearchCubit,SearchState>(builder: (context,state){
             if(state is SearchLoadingState){
               return const Center(child: LoadingWidget());
             }
             if(state is SearchErrorState){
               return AppError(msg: state.message, retry: (){
                 if(searchController.text.isNotEmpty) {
                   context.read<SearchCubit>().search(searchController.text, dataSets[selectedDateSet].toJson(), selectedSearchType.toJson());
                 }

               });
             }
             return   documents.isNotEmpty? ListView.separated(
               physics: const ClampingScrollPhysics(),
                 padding: const EdgeInsets.only(bottom: 100),
                 shrinkWrap: true,
                 itemBuilder: (context,index){
                   return  Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                     child: ReadMoreText(
                       documents[index].text,
                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                       trimMode: TrimMode.Line,
                       trimLines: 3,
                       colorClickableText: Theme.of(context).colorScheme.primary,
                       trimCollapsedText: 'read more',
                       trimExpandedText: ' show less',
                       moreStyle: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                         color: Theme.of(context).colorScheme.primary,
                       ),
                       lessStyle: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                         color: Theme.of(context).colorScheme.primary,
                       ),
                     ),
                   );
                 }, separatorBuilder: (context,index){
               return Divider(
                 indent: 16,
                 endIndent: 16,
                 color: Theme.of(context).colorScheme.outlineVariant,
                 height: 24,
               );
             }, itemCount: documents.length):
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 48),
               child: Assets.svgs.search.svg(),
             );
           }),

          ],
        ),
      ),
    );
  }
}
