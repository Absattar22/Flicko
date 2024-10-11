import '../../models/categories_model.dart';
import 'custom_container.dart';
import 'package:flutter/material.dart';

class CustomCategoryBuilder extends StatefulWidget {
  const CustomCategoryBuilder({super.key, required this.onTap});

  final void Function(int categoryId, String title)? onTap;

  @override
  State<CustomCategoryBuilder> createState() => _CustomCategoryBuilderState();
}

class _CustomCategoryBuilderState extends State<CustomCategoryBuilder> {
  final List<CategoriesModel> categories = [
    CategoriesModel(
      id: 28,
      title: 'Action',
      imgUrl:
          'https://i0.wp.com/thegameofnerds.com/wp-content/uploads/2021/06/Walker-3.png?resize=1280%2C640&ssl=1',
    ),
    CategoriesModel(
      id: 12,
      title: 'Adventure',
      imgUrl:
          'https://static0.gamerantimages.com/wordpress/wp-content/uploads/2023/06/jumanji2.jpg?q=50&fit=crop&w=1100&h=618&dpr=1.5',
    ),
    CategoriesModel(
      id: 35,
      title: 'Comedy',
      imgUrl:
          'https://www.intofilm.org/intofilm-production/scaledcropped/970x546https%3A/s3-eu-west-1.amazonaws.com/images.cdn.filmclub.org/film__4103-rush-hour--hi_res-9e180d2e.jpg/film__4103-rush-hour--hi_res-9e180d2e.jpg',
    ),
    CategoriesModel(
      id: 80,
      title: 'Crime',
      imgUrl:
          'https://imageio.forbes.com/specials-images/imageserve/65480fb49aafcdd8f056887a/Seven-547486671-large/960x0.png?format=png&width=1440',
    ),
    CategoriesModel(
      id: 18,
      title: 'Drama',
      imgUrl:
          'https://compote.slate.com/images/3c93eded-581a-43c6-ba9d-596af8eabe8e.jpeg?crop=1100%2C733%2Cx0%2Cy0&width=1280',
    ),
    CategoriesModel(
      id: 14,
      title: 'Fantasy',
      imgUrl:
          'https://www.hollywoodreporter.com/wp-content/uploads/2020/08/harry_potter_and_the_sorcerers_stone_-_photofest_still_3_-_h_2020_.jpg?w=1296&h=730&crop=1',
    ),
    CategoriesModel(
      id: 36,
      title: 'Historical',
      imgUrl:
          'https://duet-cdn.vox-cdn.com/thumbor/0x0:2233x1022/640x640/filters:focal(1064x460:1065x461):format(webp)/cdn.vox-cdn.com/uploads/chorus_asset/file/24796653/OPR_Tsr1Sht4_RGB_2.jpeg',
    ),
    CategoriesModel(
      id: 27,
      title: 'Horror',
      imgUrl:
          'https://static1.srcdn.com/wordpress/wp-content/uploads/2023/09/lorraine-warren-and-all-the-evil-spirits-in-the-conjuring-franchise.jpg?q=50&fit=crop&w=1100&h=618&dpr=1.5',
    ),
    CategoriesModel(
      id: 9648,
      title: 'Mystery',
      imgUrl:
          'https://variety.com/wp-content/uploads/2016/10/sherlock-holmes.jpg?w=1000&h=562&crop=1',
    ),
    CategoriesModel(
      id: 10749,
      title: 'Romance',
      imgUrl:
          'https://variety.com/wp-content/uploads/2020/02/all-the-bright-places.jpg?w=1000&h=667&crop=1',
    ),
    CategoriesModel(
      id: 878,
      title: 'Science Fiction',
      imgUrl:
          'https://edgroom-blogs.s3.ap-south-1.amazonaws.com/202310071805064792540_38983_u23h.jpg',
    ),
    CategoriesModel(
      id: 53,
      title: 'Thriller',
      imgUrl:
          'https://assets.mubicdn.net/images/film/26320/image-w1280.jpg?1546556409',
    ),
    CategoriesModel(
      id: 16,
      title: 'Animation',
      imgUrl:
          'https://platform.polygon.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/25528394/INSIDE_OUT_2_ONLINE_USE_i140_15mT_pub.pub16.1581.jpg?quality=90&strip=all&crop=18.603515625%2C0%2C62.79296875%2C100&w=828',
    ),
    CategoriesModel(
      id: 10752,
      title: 'War',
      imgUrl:
          'https://static01.nyt.com/images/2014/08/03/arts/03FURY/03FURY-jumbo.jpg?quality=75&auto=webp',
    ),
    CategoriesModel(
      id: 10751,
      title: 'Family',
      imgUrl:
          'https://www.arageek.com/wp-content/uploads/2020/07/%D8%A7%D9%84%D8%B3%D8%B9%D9%8A-%D9%88%D8%B1%D8%A7%D8%A1-%D8%A7%D9%84%D8%B3%D8%B9%D8%A7%D8%AF%D8%A9-2.jpg',
    ),
    CategoriesModel(
      id: 10402,
      title: 'Musical',
      imgUrl:
          'https://vid.alarabiya.net/images/2017/02/13/c8c80b8c-824c-470d-86d8-edac45fe9933/c8c80b8c-824c-470d-86d8-edac45fe9933.png?crop=4:3&width=1200',
    ),
    CategoriesModel(
      id: 99,
      title: 'Documentary',
      imgUrl:
          'https://cdn.theplaylist.net/wp-content/uploads/2023/06/26104935/Stephen-curry-underrated.jpg',
    ),
    CategoriesModel(
      id: 37,
      title: 'Western',
      imgUrl:
          'https://m.media-amazon.com/images/M/MV5BNWE3N2E3YzQtNzdlMy00NzBmLWE3NmQtYTExYmIzYmZiMGE5XkEyXkFqcGdeQVRoaXJkUGFydHlJbmdlc3Rpb25Xb3JrZmxvdw@@._V1_QL75_UX500_CR0,0,500,281_.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:  2,
          crossAxisSpacing: screenWidth > 600 ? 20 : 8,
          mainAxisSpacing: screenHeight > 900 ? 20 : 8,
          childAspectRatio: 1.1,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CustomContainer(
            title: categories[index].title,
            imgUrl: categories[index].imgUrl,
            onTap: () => widget.onTap?.call(
              categories[index].id,
              categories[index].title,
            ),
          );
        },
      ),
    );
  }
}
