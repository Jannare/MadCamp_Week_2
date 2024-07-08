import 'package:flutter/material.dart';
class chattab extends StatelessWidget {
	const chattab({super.key});
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(
				child: Container(
					constraints: BoxConstraints.expand(),
					color: Color(0xFFFFFFFF),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Expanded(
								child: Container(
									decoration: BoxDecoration(
										border: Border.all(
											color: Color(0xFF000000),
											width: 1,
										),
										color: Color(0xFFFFFFFF),
										boxShadow: [
											BoxShadow(
												color: Color(0x4D000000),
												blurRadius: 4,
												offset: Offset(0, 4),
											),
										],
									),
									width: double.infinity,
									height: double.infinity,
									child: SingleChildScrollView(
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													IntrinsicHeight(
														child: Container(
															width: double.infinity,
															child: Stack(
																	clipBehavior: Clip.none,
																	children: [
																		Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Container(
																						padding: EdgeInsets.only( top: 55, bottom: 286),
																						height: 780,
																						width: double.infinity,
																						decoration: BoxDecoration(
																							image: DecorationImage(
																									image: AssetImage('assets/images/background.png'),
																									fit: BoxFit.cover
																							),
																						),
																						child: Column(
																								crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									IntrinsicHeight(
																										child: Container(
																											margin: EdgeInsets.only( bottom: 7, left: 20, right: 20),
																											width: double.infinity,
																											child: Row(
																													children: [
																														Container(
																																margin: EdgeInsets.only( right: 6),
																																width: 10,
																																height: 17,
																																child: Image.asset(
																																	'assets/chattab/back.png',
																																	fit: BoxFit.fill,
																																)
																														),
																														Text(
																															'1',
																															style: TextStyle(
																																color: Color(0xFF000000),
																																fontSize: 17,
																															),
																														),
																														Expanded(
																															child: Container(
																																width: double.infinity,
																																child: SizedBox(),
																															),
																														),
																														Container(
																															margin: EdgeInsets.only( right: 11),
																															child: Text(
																																'방제목',
																																style: TextStyle(
																																	color: Color(0xFF000000),
																																	fontSize: 16,
																																),
																															),
																														),
																														Container(
																															margin: EdgeInsets.only( right: 111),
																															child: Text(
																																'1',
																																style: TextStyle(
																																	color: Color(0xFF555C62),
																																	fontSize: 16,
																																),
																															),
																														)
																													]
																											),
																										),
																									),
																									IntrinsicHeight(
																										child: Container(
																											decoration: BoxDecoration(
																												borderRadius: BorderRadius.circular(2),
																												color: Color(0xFFFFFFFF),
																												boxShadow: [
																													BoxShadow(
																														color: Color(0x4D000000),
																														blurRadius: 2,
																														offset: Offset(0, 1),
																													),
																												],
																											),
																											padding: EdgeInsets.only( top: 16, bottom: 16, left: 18, right: 18),
																											margin: EdgeInsets.only( bottom: 11),
																											width: double.infinity,
																											child: Row(
																													children: [
																														Container(
																																margin: EdgeInsets.only( right: 17),
																																width: 17,
																																height: 15,
																																child: Image.asset(
																																	'assets/chattab/Notice',
																																	fit: BoxFit.fill,
																																)
																														),
																														Text(
																															'공지 내용',
																															style: TextStyle(
																																color: Color(0xFF000000),
																																fontSize: 15,
																															),
																														)
																													]
																											),
																										),
																									),
																									IntrinsicHeight(
																										child: Container(
																											margin: EdgeInsets.only( bottom: 10, left: 11, right: 11),
																											width: double.infinity,
																											child: Row(
																													crossAxisAlignment: CrossAxisAlignment.start,
																													children: [
																														Container(
																																decoration: BoxDecoration(
																																	borderRadius: BorderRadius.circular(13),
																																),
																																margin: EdgeInsets.only( right: 7),
																																width: 34,
																																height: 34,
																																child: ClipRRect(
																																		borderRadius: BorderRadius.circular(13),
																																		child: Image.asset(
																																			'asset/chattab/profilePic.png',
																																			fit: BoxFit.fill,
																																		)
																																)
																														),
																														IntrinsicHeight(
																															child: Container(
																																margin: EdgeInsets.only( top: 1, right: 5),
																																width: 59,
																																child: Column(
																																		crossAxisAlignment: CrossAxisAlignment.start,
																																		children: [
																																			Container(
																																				margin: EdgeInsets.only( bottom: 6),
																																				child: Text(
																																					'이름',
																																					style: TextStyle(
																																						color: Color(0xFF000000),
																																						fontSize: 12,
																																					),
																																				),
																																			),
																																			IntrinsicHeight(
																																				child: Container(
																																					decoration: BoxDecoration(
																																						borderRadius: BorderRadius.circular(13),
																																						color: Color(0xFFFFFFFF),
																																					),
																																					padding: EdgeInsets.symmetric(vertical: 11),
																																					width: double.infinity,
																																					child: Column(
																																							children: [
																																								Text(
																																									'텍스트',
																																									style: TextStyle(
																																										color: Color(0xFF282A2B),
																																										fontSize: 15,
																																									),
																																								),
																																							]
																																					),
																																				),
																																			),
																																		]
																																),
																															),
																														),
																														Expanded(
																															child: Container(
																																margin: EdgeInsets.only( top: 44),
																																width: double.infinity,
																																child: Text(
																																	'1',
																																	style: TextStyle(
																																		color: Color(0xFFFBEA58),
																																		fontSize: 11,
																																	),
																																),
																															),
																														),
																													]
																											),
																										),
																									),
																									IntrinsicHeight(
																										child: Container(
																											margin: EdgeInsets.only( bottom: 19, left: 14, right: 14),
																											width: double.infinity,
																											child: Row(
																													mainAxisAlignment: MainAxisAlignment.spaceBetween,
																													crossAxisAlignment: CrossAxisAlignment.start,
																													children: [
																														IntrinsicHeight(
																															child: Container(
																																margin: EdgeInsets.only( top: 12),
																																width: 26,
																																child: Column(
																																		crossAxisAlignment: CrossAxisAlignment.start,
																																		children: [
																																			Container(
																																				margin: EdgeInsets.only( bottom: 2),
																																				child: Text(
																																					'1',
																																					style: TextStyle(
																																						color: Color(0xFFFBEA58),
																																						fontSize: 11,
																																					),
																																				),
																																			),
																																			Text(
																																				'00:00',
																																				style: TextStyle(
																																					color: Color(0xFF000000),
																																					fontSize: 10,
																																				),
																																			),
																																		]
																																),
																															),
																														),
																														IntrinsicHeight(
																															child: Container(
																																width: 61,
																																child: Stack(
																																		clipBehavior: Clip.none,
																																		children: [
																																			Column(
																																					crossAxisAlignment: CrossAxisAlignment.start,
																																					children: [
																																						IntrinsicHeight(
																																							child: Container(
																																								decoration: BoxDecoration(
																																									borderRadius: BorderRadius.circular(13),
																																									color: Color(0xFFDCFBD7),
																																								),
																																								padding: EdgeInsets.symmetric(vertical: 11),
																																								width: double.infinity,
																																								child: Column(
																																										children: [
																																											Text(
																																												'텍스트',
																																												style: TextStyle(
																																													color: Color(0xFF282A2B),
																																													fontSize: 15,
																																												),
																																											),
																																										]
																																								),
																																							),
																																						),
																																					]
																																			),
																																			Positioned(
																																				top: 0,
																																				right: 0,
																																				width: 7,
																																				height: 12,
																																				child: Container(
																																						transform: Matrix4.translationValues(3, -3, 0),
																																						width: 7,
																																						height: 12,
																																						child: Image.asset(
																																							'assets/chattab/tail2',
																																							fit: BoxFit.fill,
																																						)
																																				),
																																			),
																																		]
																																),
																															),
																														),
																													]
																											),
																										),
																									),
																									IntrinsicHeight(
																										child: Container(
																											decoration: BoxDecoration(
																												borderRadius: BorderRadius.circular(34),
																												color: Color(0x26000000),
																											),
																											padding: EdgeInsets.symmetric(vertical: 7),
																											margin: EdgeInsets.only( bottom: 54, left: 115, right: 115),
																											width: double.infinity,
																											child: Column(
																													children: [
																														Text(
																															'0000년 0월 0일 월요일',
																															style: TextStyle(
																																color: Color(0xFFF8F8F9),
																																fontSize: 11.5,
																															),
																														),
																													]
																											),
																										),
																									),
																									IntrinsicHeight(
																										child: Container(
																											decoration: BoxDecoration(
																												border: Border.all(
																													color: Color(0xFF000000),
																													width: 1,
																												),
																												borderRadius: BorderRadius.circular(15),
																												color: Color(0xFF8C5B3F),
																												boxShadow: [
																													BoxShadow(
																														color: Color(0x4D000000),
																														blurRadius: 4,
																														offset: Offset(0, 4),
																													),
																												],
																											),
																											padding: EdgeInsets.only( left: 20, right: 20),
																											margin: EdgeInsets.only( bottom: 14, left: 70, right: 70),
																											width: double.infinity,
																											child: Column(
																													crossAxisAlignment: CrossAxisAlignment.start,
																													children: [
																														IntrinsicHeight(
																															child: Container(
																																decoration: BoxDecoration(
																																	borderRadius: BorderRadius.circular(10),
																																	color: Color(0xFFDCFCD7),
																																),
																																padding: EdgeInsets.only( top: 22, bottom: 22, left: 28, right: 28),
																																margin: EdgeInsets.only( top: 10),
																																width: double.infinity,
																																child: Column(
																																		crossAxisAlignment: CrossAxisAlignment.start,
																																		children: [
																																			Container(
																																				width: double.infinity,
																																				child: Text(
																																					'{사용자 이름} 님의\n 마니또 맞추기',
																																					style: TextStyle(
																																						color: Color(0xFF000000),
																																						fontSize: 16,
																																					),
																																				),
																																			),
																																		]
																																),
																															),
																														),
																													]
																											),
																										),
																									),
																									IntrinsicHeight(
																										child: Container(
																											decoration: BoxDecoration(
																												border: Border.all(
																													color: Color(0xFF000000),
																													width: 1,
																												),
																												borderRadius: BorderRadius.circular(10),
																												color: Color(0xFFFFFFFF),
																												boxShadow: [
																													BoxShadow(
																														color: Color(0x4D000000),
																														blurRadius: 4,
																														offset: Offset(0, 4),
																													),
																												],
																											),
																											padding: EdgeInsets.symmetric(vertical: 9),
																											margin: EdgeInsets.symmetric(horizontal: 39),
																											width: double.infinity,
																											child: Column(
																													children: [
																														Text(
																															'마니또를 맞춰보세요!',
																															style: TextStyle(
																																color: Color(0xFF000000),
																																fontSize: 20,
																															),
																														),
																													]
																											),
																										),
																									),
																								]
																						),
																					),
																				]
																		),
																		Positioned(
																			bottom: 0,
																			left: 1,
																			width: 360,
																			height: 120,
																			child: Container(
																				decoration: BoxDecoration(
																					borderRadius: BorderRadius.circular(15),
																					color: Color(0xFF8C5B3F),
																				),
																				padding: EdgeInsets.only( left: 9, right: 9),
																				transform: Matrix4.translationValues(0, 30, 0),
																				width: 360,
																				height: 120,
																				child: Column(
																						crossAxisAlignment: CrossAxisAlignment.start,
																						children: [
																							IntrinsicHeight(
																								child: Container(
																									margin: EdgeInsets.only( top: 30),
																									width: double.infinity,
																									child: Row(
																											mainAxisAlignment: MainAxisAlignment.spaceBetween,
																											children: [
																												Container(
																													decoration: BoxDecoration(
																														border: Border.all(
																															color: Color(0xFF90949B),
																															width: 1,
																														),
																														borderRadius: BorderRadius.circular(7),
																													),
																													width: 22,
																													height: 22,
																													child: Image.asset(
																														'assets/chattab/tail2',
																														fit: BoxFit.fill,
																													)
																												),
																												Container(
																													decoration: BoxDecoration(
																														border: Border.all(
																															color: Color(0xFFDEDEDE),
																															width: 1,
																														),
																														borderRadius: BorderRadius.circular(17),
																														color: Color(0xFFE5D6CE),
																													),
																													width: 310,
																													height: 30,
																													child: SizedBox(),
																												),
																											]
																									),
																								),
																							),
																						]
																				),
																			),
																		),
																	]
															),
														),
													),
												],
											)
									),
								),
							),
						],
					),
				),
			),
		);
	}
}