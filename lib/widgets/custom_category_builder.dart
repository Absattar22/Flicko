import 'package:flicko/constants.dart';
import 'package:flicko/models/categories_model.dart';
import 'package:flicko/widgets/custom_category.dart';
import 'package:flutter/material.dart';

class CustomCategoryBuilder extends StatefulWidget {
  const CustomCategoryBuilder({super.key});

  @override
  State<CustomCategoryBuilder> createState() => _CustomCategoryBuilderState();
}

class _CustomCategoryBuilderState extends State<CustomCategoryBuilder> {
  final List<CategoriesModel> categories = [
    CategoriesModel(
      title: 'Action',
      imgUrl:
          'https://i0.wp.com/thegameofnerds.com/wp-content/uploads/2021/06/Walker-3.png?resize=1280%2C640&ssl=1',
    ),
    CategoriesModel(
      title: 'Adventure',
      imgUrl:
          'https://static0.gamerantimages.com/wordpress/wp-content/uploads/2023/06/jumanji2.jpg?q=50&fit=crop&w=1100&h=618&dpr=1.5',
    ),
    CategoriesModel(
      title: 'Comedy',
      imgUrl:
          'https://www.intofilm.org/intofilm-production/scaledcropped/970x546https%3A/s3-eu-west-1.amazonaws.com/images.cdn.filmclub.org/film__4103-rush-hour--hi_res-9e180d2e.jpg/film__4103-rush-hour--hi_res-9e180d2e.jpg',
    ),
    CategoriesModel(
      title: 'Crime',
      imgUrl:
          'https://imageio.forbes.com/specials-images/imageserve/65480fb49aafcdd8f056887a/Seven-547486671-large/960x0.png?format=png&width=1440',
    ),
    CategoriesModel(
      title: 'Drama',
      imgUrl:
          'https://compote.slate.com/images/3c93eded-581a-43c6-ba9d-596af8eabe8e.jpeg?crop=1100%2C733%2Cx0%2Cy0&width=1280',
    ),
    CategoriesModel(
      title: 'Fantasy',
      imgUrl:
          'https://www.hollywoodreporter.com/wp-content/uploads/2020/08/harry_potter_and_the_sorcerers_stone_-_photofest_still_3_-_h_2020_.jpg?w=1296&h=730&crop=1',
    ),
    CategoriesModel(
      title: 'Historical',
      imgUrl:
          'https://duet-cdn.vox-cdn.com/thumbor/0x0:2233x1022/640x640/filters:focal(1064x460:1065x461):format(webp)/cdn.vox-cdn.com/uploads/chorus_asset/file/24796653/OPR_Tsr1Sht4_RGB_2.jpeg',
    ),
    CategoriesModel(
      title: 'Horror',
      imgUrl:
          'https://static1.srcdn.com/wordpress/wp-content/uploads/2023/09/lorraine-warren-and-all-the-evil-spirits-in-the-conjuring-franchise.jpg?q=50&fit=crop&w=1100&h=618&dpr=1.5',
    ),
    CategoriesModel(
      title: 'Mystery',
      imgUrl:
          'https://variety.com/wp-content/uploads/2016/10/sherlock-holmes.jpg?w=1000&h=562&crop=1',
    ),
    CategoriesModel(
      title: 'Romance',
      imgUrl:
          'https://variety.com/wp-content/uploads/2020/02/all-the-bright-places.jpg?w=1000&h=667&crop=1',
    ),
    CategoriesModel(
      title: 'Science Fiction',
      imgUrl:
          'https://edgroom-blogs.s3.ap-south-1.amazonaws.com/202310071805064792540_38983_u23h.jpg',
    ),
    CategoriesModel(
      title: 'Thriller',
      imgUrl:
          'https://assets.mubicdn.net/images/film/26320/image-w1280.jpg?1546556409',
    ),
    CategoriesModel(
      title: 'Animation',
      imgUrl:
          'https://platform.polygon.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/25528394/INSIDE_OUT_2_ONLINE_USE_i140_15mT_pub.pub16.1581.jpg?quality=90&strip=all&crop=18.603515625%2C0%2C62.79296875%2C100&w=828',
    ),
    CategoriesModel(
      title: 'War',
      imgUrl:
          'https://static01.nyt.com/images/2014/08/03/arts/03FURY/03FURY-jumbo.jpg?quality=75&auto=webp',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.2,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CustomCategory(
            title: categories[index].title,
            imgUrl: categories[index].imgUrl,
          );
        },
      ),
    );
  }
}
