import 'package:flash_card_app/model/category.dart';

List<Map<String, dynamic>> wordData = [
  // Animal
  {
    "id": 100000,
    "category": CategoryCode.animal,
    "korWord": "고양이",
    "engWord": "Cat",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhjEaM6ETRFsaCy3bC-Wyhwh7rLxtwuXnBM96Z3sZHwNmMjaWZDBlj8DFzEE2Q-_n1JZmKnNhVTO6nIAVwT5ek6a_RHiWAzXH-rBVampsdesu5aXjRLXR4ILNlFptdydrxRyfNP70xaEEv8/s849/cat_kotatsu_neko.png",
    "history": []
  },
  {
    "id": 100001,
    "category": CategoryCode.animal,
    "korWord": "강아지",
    "engWord": "Dog",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi1IFHx25kvv10ePqjuGCm3EW-mXpb5Tpe9Uh3CVVdtKuqg0Fj6FI529Cs9dQ1gJCNHwJpMBP9niIya-NtUV715OszQPMA2733FV-4t-9c3_SMpT0sLQzJHXiJ6j5uIASQ53Ku2JvSsuRBs/s793/science_pavlof_dog.png",
    "history": []
  },
  {
    "id": 100002,
    "category": CategoryCode.animal,
    "korWord": "코끼리",
    "engWord": "Elephant",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgOBpYAOMhBNGADvk8MnysY0e3KDybKgWeFe2odKxSjP2LYxHs0UHAl3-OC2nkhiJhYw0j5kVNX95A_g25WYKfZ2Oof9-6s6Xd5q-O0Z1PsoOEGlMTMbWdJ1F7H3XXBU9sckdGAUeMdKjY/s450/monogatari_kusari_tsunagareta_zou.png",
    "history": []
  },
  {
    "id": 100003,
    "category": CategoryCode.animal,
    "korWord": "호랑이",
    "engWord": "Tiger",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjm2-_eXVjEvYx4Ma7Z9FIVnROdu31Guh5VzJ1musaitxxmct5i6Z6CowFVcXliUult_a9kKrZPXw1f_xCsnhrdrE2oNMdtFB6IbTgan5RPEbXSbE0Aqf9h54EjqKGNu2N29RvPKWdxK_U/s400/animal_stand_tora.png",
    "history": []
  },
  {
    "id": 100004,
    "category": CategoryCode.animal,
    "korWord": "사자",
    "engWord": "Lion",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEir5tpx2reg30rZPapXdWowGpl96CIPtOMhmU-hOYn_DJN2DE75Tsj7PZaqVnN6g-6PO7ZxT3oc40OIfJYPCdKaE5YOjdn5kVNsU0s-O03QMtcxDL7szMZnL0MQu14NOTQuZiFFekEgfuk/s450/animal_stand_lion.png",
    "history": []
  },
  // Plant
  {
    "id": 100100,
    "category": CategoryCode.plant,
    "korWord": "나무",
    "engWord": "Tree",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi4smEJ9c_uE_p_F71v5JNtsQQKYKY55v1UXAHkHmvJ27Q-8P8l4kT7WuXQV2DZmt2a7ufyoPGij-oeqLza6HJ7yUVFcHisAzXVYiVS_P93WH4_xSmagnkVcwk5ijeVL20JIEqJ64yw-BA/s800/tree_seichou08.png",
    "history": []
  },
  {
    "id": 100101,
    "category": CategoryCode.plant,
    "korWord": "꽃",
    "engWord": "Flower",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg-htdlVaJSQ2LpvAzq4IwWJXzTRnHMO8xd83i6hC3J_v-WBDQJZ4YnvK7n0xxMEkA27Anx6N82Jg9BWke-1PxLJvokJ5HMOf3JhoPO6lq_uo_z0lHUxJO98WD9Ne3vezt7cZCs76iU2WD-/s800/flower_kikyou.png",
    "history": []
  },
  {
    "id": 100102,
    "category": CategoryCode.plant,
    "korWord": "풀",
    "engWord": "Grass",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiHsoZ1vzTa7lm91NM2kCaj-pYiC6svX6bHpFqbPW8iLQQ-iGR-6EYiQ7NCxR_phH6YgLkj1dRDxjTvlY4tvLfjCEzgyAJ_K4lKsz7Z2WhU-PoV9OO33vqAWWnzsWTtp3-HDIZLGNCi3_QT/s300/kusa_simple2.png",
    "history": []
  },
  {
    "id": 100103,
    "category": CategoryCode.plant,
    "korWord": "선인장",
    "engWord": "Cactus",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjomrukNANHjGrxT1FeF-y0BPJZfkFJeF6K_ojpx8QuCKrA6irNppEdt5vVSn6ob6cL6QALOXh-ZtNtP4MKz6N8g_bT1vS0iLMc5Nz77WcSbfXnAVajXDH-1Zue8JUt0Yngso2Gd8aPfvoU/s300/plant_saboten1.png",
    "history": []
  },
  {
    "id": 100104,
    "category": CategoryCode.plant,
    "korWord": "이끼",
    "engWord": "Moss",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh1JHqIN173cOrxUQ6Y1VivflhqE-QWERPDMRt-e1GzpP2wmT5tdL9gmhMGjPXMeQhIFe6ZCGpZ65J__YKanYuHkhsJXm0cslGpCV-aV1fF4qZT5TCQ3PFA3xqU0YpGS7N1Qeq4qnVi58NO/s400/nature_stone_ishi_iwa_kokemushi.png",
    "history": []
  },
  // Food
  {
    "id": 100200,
    "category": CategoryCode.food,
    "korWord": "사과",
    "engWord": "Apple",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiReo-clW-ie2iyVfoqgamuJqB2FMZt6SDeVg0Eiy9gRIJn7LZjQGdhQt5LgVsuczLIwcTwRVxufw4DIjZ3hNOAU9nGHDfD1RGc4E-SxwBEo3IdqSX2P0trhhbT2cvTjOkh_7zwqiXRh0ec/s400/fruit_apple.png",
    "history": []
  },
  {
    "id": 100201,
    "category": CategoryCode.food,
    "korWord": "바나나",
    "engWord": "Banana",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjDTy81qEYQ7MLvImTaqiWn_8Wu16qPSIVeJP0Aae64gv07aXn1vB7bYczEbPjMqj-CEgAe9DMTD4KkQ2kq83y1tYUcJF3RbF7LJAe0qZLRVwd667uFMHukkjcEC1rzWheoOtGI1eqhCywi/s400/fruit_banana.png",
    "history": []
  },
  {
    "id": 100202,
    "category": CategoryCode.food,
    "korWord": "치즈",
    "engWord": "Cheese",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiTZbegS141P-KErJbaE731mBnZTXAQ_6T1oOTJhZ0Yl_GXP_zvBgM0qkS1IY7G84xvt4mRGkyvuMMlMYLgC7IGMfk7CBGeo1b1US51gAUYEhfndloXV0cFyuN9P-iu1COYcPslWDC1ZbSX/s1600/food_cheese_emmental.png",
    "history": []
  },
  {
    "id": 100203,
    "category": CategoryCode.food,
    "korWord": "빵",
    "engWord": "Bread",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEglZSHjgkbnR-bZubdCxSDhElS8f-td6GBrPlRd60iLQFkWfP6QSh1hPBa8vdegWixfyVDx4ud0_U0pAIpXwoe_mehwtEb8x8IGhCfRJ9etA31duwdkpKQzHJ1wk3piazX9MTJvfnhyokz2/s400/pan_bread_1kin_yama.png",
    "history": []
  },
  {
    "id": 100204,
    "category": CategoryCode.food,
    "korWord": "피자",
    "engWord": "Pizza",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEijnnnXzseyv8G5Y3bqtOfJe3hRg3McyQaZAdYJkmlXf6gO8mnnL80bciX7jI2TUHTMsPMitftjLtwBNGsDl8JXf2IC40elWijvbFTM9gU2BZq478kKqTVVKKutEp1KWhX66-O4ExPHKFEt/s400/pizza_margherita.png",
    "history": []
  },
  // Occupation
  {
    "id": 100300,
    "category": CategoryCode.occupation,
    "korWord": "의사",
    "engWord": "Doctor",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjkRI-l17wNGPBJnqGDkc__krbVHcPmxmPlYePohQzpfxD-E2NHOtt2byRfWPMu1wgL8qAyz-9rionxI9fp8YauFb2yLiVvuYnWzTpNAD8LQUy3bbQf9cVeWL9r2AjRFWAw-fC1Xw5AXVY/s400/doctor.png",
    "history": []
  },
  {
    "id": 100301,
    "category": CategoryCode.occupation,
    "korWord": "선생님",
    "engWord": "Teacher",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjmZLcuoQ2xxyuCo8bLsqehQH8al3txeeXib53UaNM-lZ9-lWY4rj8KTZjyLpVI3LoNgtm-tYn5VLX4yjssHPEIwBM-dl8N1iJURjuIlf-GOyeSIcQqBIte7mZ7W70vN6VhjZxQTLQZ9mNb/s450/job_teacher_man.png",
    "history": []
  },
  {
    "id": 100302,
    "category": CategoryCode.occupation,
    "korWord": "경찰관",
    "engWord": "Police Officer",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi87FeWdv1Qj4HF50lrBaWJBnecU8-mQigeTSfjRaRclLSttukh3kym9DE4uC0q76UbsU-UHpkYrCCvjdqVpqPeYlQGu5pVBeTt3x6r4TRN9UwvgtYpwsx7_NVX8VfwcuARv2M_otSVowob/s450/job_police_newyork_man.png",
    "history": []
  },
  {
    "id": 100303,
    "category": CategoryCode.occupation,
    "korWord": "소방관",
    "engWord": "Firefighter",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgD8K8x0j4mL-rYcZCf1nTUFOqZBGrHQHzx_FN1z_Bcx8Mw83xfiOc9YqR0Wz50XPInB02e-65IaC0TkzZOI6XXGxa9KbHxZg1gQLuF219ihqkjkHIqQkRsUwx0mNhWQiWIM4Ntb4EIcey1/s450/job_syokugyou_taiken_syouboushi_girl.png",
    "history": []
  },
  {
    "id": 100304,
    "category": CategoryCode.occupation,
    "korWord": "요리사",
    "engWord": "Chef",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgB68ppVgxqGC7bGvfao6ixVvW0J5zTV3of7JjId7CjGBE8gjyYpOZH-lJrnDvNZeJC5XNEhBD7fcvGkHNRKwCkz9CiWF-E4UUgQf2PJ2vNUC2B-ZizIGEQ_mbhRr-18mhPAA_rxGp8Hanc/s800/cooking_chef.png",
    "history": []
  },
  // Nature
  {
    "id": 100400,
    "category": CategoryCode.nature,
    "korWord": "산",
    "engWord": "Mountain",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgLfT2PN3rFeSw8l4lVexYxKwiOJwBGd-LIZtt66ASy3LRdgEJMpBULHBH94mUGC3z9_ObboafFaHamVbe3wF_icmJV_OE6k9FGIa5mTZrttbf3wXtOtnIxf7SGabZUL172zObMF91QVss/s800/mountain_ama_dablam.png",
    "history": []
  },
  {
    "id": 100401,
    "category": CategoryCode.nature,
    "korWord": "바다",
    "engWord": "Ocean",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjs8k44SsDb6i5mCB_NrLv5FS_JwCxA5pc0YCWkECYpXpU6Pl_JJr0EvnV0Tu973gHNIeUvoHgjprsNCquaMMJLyXdIgheQQVb2vLWLobzUD9AeBgynNcPYARJ6rZazlRPDdKIPVu2hbjqA/s800/ocean_night.png",
    "history": []
  },
  {
    "id": 100402,
    "category": CategoryCode.nature,
    "korWord": "강",
    "engWord": "River",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgwNjD2LNi_OFldmOhJprBSWS1WiYGGCQ9r02TzUwHmguk9RmNK6HgPi_6X_t30BV7kthZtA0gTghEMUsOz1x1pZJqC8Az4Lb-t2Q_LH1DVnHwqYoiBXAV_Rd4n_HKqpH6vOmqqV7brZ7k/s800/kawa_kasenjiki_hatake.png",
    "history": []
  },
  {
    "id": 100403,
    "category": CategoryCode.nature,
    "korWord": "하늘",
    "engWord": "Sky",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjPXMeJ4RuGi0fmBUptL2kLsK64VlpavFHiaVwCiRGozunBNUKKLPp6g0jG_XH4xJKeV3xOOFCwrpVWvMNzMmF78DjWPAFa0Zm_kHWowHgNj44rTUFT40imYfw8cI-vE2T8vjr8IKIoctY/s800/uyuni_enko.png",
    "history": []
  },
  {
    "id": 100404,
    "category": CategoryCode.nature,
    "korWord": "숲",
    "engWord": "Forest",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj9nSlEdzOidnQt0USF9t7eH1RAUmOb-XUVRNhRl2uVQsyv_ApsFy9RyUhQAUFm9C-Atd_1jMZmzrdUraTh-HKrE09sQxj_yc4xBo48KIioEK3CvJGFOcRXkTbNswoGozKQwfdr4u4CC3nb/s600/bg_natural_mori.jpg",
    "history": []
  },
  // Transportation
  {
    "id": 100500,
    "category": CategoryCode.transportation,
    "korWord": "자동차",
    "engWord": "Car",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiv5JeCIwFNrcu0jUgHhoM4Jtea8_zBkMFQmUhAQUJDd9lfwybB6eqXsJVtCVxQW3C6bRJuHl_ilOwN3NRwiWuknnQYDK3PCVUIqTxR0ygWEV2szreZd0mB6hkCPJ7k860yTFhs387QJkHe/s500/car_coupe_white.png",
    "history": []
  },
  {
    "id": 100501,
    "category": CategoryCode.transportation,
    "korWord": "버스",
    "engWord": "Bus",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh_RmbVgFTL-3JbD2VEl7q0ksw1pk5jflUnY_CUgnrhtiozYJrhtgvWZHX56J9Iv9f_1kKSKxNLL6qtx1RawdwQwNxInljvPlRnf88PfjHzs-QYFya3ycTXpCoYxZtorf97tyGw6XfDt1Q/s800/car_bus_seibu.png",
    "history": []
  },
  {
    "id": 100502,
    "category": CategoryCode.transportation,
    "korWord": "기차",
    "engWord": "Train",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZMVFH0uk5RvnlmOKsZdpWreYlW6NV1pqHgyOPDWczZa2Bj269xqKXVh-JOhPdBmNliWuPhFFYLg6c9QTwUUMfZhnCgfcPj6CpXCGofWAEbtPN7CCGbb0MD-7CDfyVo-8hPj8SBg2IAT8/s800/train_enoden_kamakura.png",
    "history": []
  },
  {
    "id": 100503,
    "category": CategoryCode.transportation,
    "korWord": "비행기",
    "engWord": "Airplane",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjvRIdDvh5A-EbWZ0g0ghJr5U-CZxFcUnuIobcuU-JD9f2Y0mpa0Va0RJxOTMeuF5_zzNGAvsHBg_8ovIp9Q7F1XUnJNZcJ9lfKJI1tfjy30Udmj4bi0U5v-CNVzHN9j5qX015O6q6Fwatf/s800/train3_skyblue.png",
    "history": []
  },
  {
    "id": 100504,
    "category": CategoryCode.transportation,
    "korWord": "자전거",
    "engWord": "Bicycle",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgjJ6gU40-lLcvOqjERHIGkUugDClDnzJ_KwYYPdbHGVR5FK80Sz6I6ljmFPsrU43ml3zc25rCa8LRbxD9Fsm_0lfwUc150BUjJ9UTGWXBAk0LfW_R9362I7IXhwe5XyALzR2A7Bua6WhcN/s800/bicycle_cross_bike.png",
    "history": []
  },
  // Family
  {
    "id": 100600,
    "category": CategoryCode.family,
    "korWord": "아버지",
    "engWord": "Father",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjyTeldYCzV_OnSVRvnI5W56SkHq8d69GAL-TMOvYcAig4I2Vbz4yJyr6Jvf1Fz5wWU1m0FOoQzBP0h9AlFlE6vEY1UR95xnhpgv8GeYKImjd2Hp33jftSLRTatfrJMk6Y3lHdd2c_ViwcY/s800/baby_onbuhimo_man.png",
    "history": []
  },
  {
    "id": 100601,
    "category": CategoryCode.family,
    "korWord": "어머니",
    "engWord": "Mother",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh4O1xmxJ2zFMInmg_gbxmIfEsKwKZUtTqsW3v43eOilxtz5DyKlj18WWaz3EuhNigGbqgDaA3qYNhwMOVW3ItvyxSXG-C8pvI0BL3esOt7oCptTm2CDAsHE9WE21jr1zEBtnLJQtFPbcY3/s800/baby_dakko_mother.png",
    "history": []
  },
  {
    "id": 100602,
    "category": CategoryCode.family,
    "korWord": "형제",
    "engWord": "Brother",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjRG-3WqjdycVSWgikjUmTC8-W6rfPSni1qa-cPu7n_PC1cnLV4htXEnxu51fBPcKBEt3HAWW_CrihTYru9OOz8Q4Bst5odaXvobuoDA4R1euTflZRNZx0Pg1llQSpepMtjtg1QNR894fA/s400/kenka_friends.png",
    "history": []
  },
  {
    "id": 100603,
    "category": CategoryCode.family,
    "korWord": "자매",
    "engWord": "Sister",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiYQxf5gU-yDJHxgjCS9IywQutKOSOS6mevosbgL2eTTb1rnXO7PBcBdDEjVqKJHLGJWHxkYmY0EVIqUlGAmMjHUqAG3BfpodKtUGO7J_xgcd3g5pJwRxW9Y0PgB_9eO0_hvKBO2rhiXP4/s400/family_shimai.png",
    "history": []
  },
  {
    "id": 100604,
    "category": CategoryCode.family,
    "korWord": "할머니",
    "engWord": "Grandmother",
    "image":
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi6ncZ7OA6xctLeD07tvICwJqNEf9FvFulhoME5QllSra4cWal8YV3qS2gGhNO3RcIVvKlHMPZbIzMTIspxfYvmu9GbhflPaLqMCDfOuV4ZMcb5oly9AF0yDPiEQ65_PQitQmtX7FYytJU/s400/obaasan_bed.png',
    "history": []
  },
  //activity
  {
    "id": 100700,
    "category": CategoryCode.activity,
    "korWord": "수영",
    "engWord": "Swimming",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj76COz4ZuvTnNKQntXdibTXFvpocw0TqHxQGm1-XpAH94_lV4GDLTDCIW30WPSP9wqgRWxm557wAPP1Lv5qeK8QXF6fJ47YgtiUqkYGqtDficvPo-5Sz65Nh0-G25s7uS5V_eEJaHBRG20/w1200-h630-p-k-no-nu/paralympic_swimming.png",
    "history": []
  },
  {
    "id": 100701,
    "category": CategoryCode.activity,
    "korWord": "등산",
    "engWord": "Hiking",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgaPMhDFdat3MUBAjuZ_gau-vjHVsmL9EC-zQxZgJnpwl_EJfhwK1nZwF2zujho0BuwnnMvCCxTjs2XzoeoNv5_EpKrdcnUSfRA2kfe6hsK0dF1LwQrvFkYLH06RE_rS0X-29pRAZLpTooD/s800/yamanobori_couple.png",
    "history": []
  },
  {
    "id": 100702,
    "category": CategoryCode.activity,
    "korWord": "달리기",
    "engWord": "Running",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjrw5MLbPLh_uckgl-7CGbvyW1u0Lyb_MGrxVZIm2Nkl4U7JnOMBpOCNlB0HohfZZ3dnS4v1dU1kQAuOhJu0qDID17OwagNdTKNvDaC0obcA-D4niQzoP50fsml67ckvFQhDUvLul9VOtHC/s800/gym_running_people.png",
    "history": []
  },
  {
    "id": 100703,
    "category": CategoryCode.activity,
    "korWord": "요가",
    "engWord": "Yoga",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhvrs8eupfgacF2GFYbZvb2VDj-gJnCb4GU9GcUABC3fPZHaUSQZ5S_-HA_vLgPtd3_N3urrhj8sMaMaB-1uIAuBAY993o9rHw01Gk4WbAYoDxF5bdxOsByqcj9Wz5FQOcGNqtdRP-1x8s/s800/yoga_meisou.png",
    "history": []
  },
  {
    "id": 100704,
    "category": CategoryCode.activity,
    "korWord": "축구",
    "engWord": "Soccer",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiUhmNft5nFWC9hQOMuGsaJz6yZUZTprHmPqVadu0gVmyQ6K1HKDrhpibTERw60lX1q-eP0_Qx4gqolm4qz1X3PM_waopI3ekcFScybWRzuEwmlTf6kG7GaD-DyPATXP7utlmbAowJYqgqw/s800/sports_soccer_man_asia.png",
    "history": []
  },
  //culture
  {
    "id": 100800,
    "category": CategoryCode.culture,
    "korWord": "영화",
    "engWord": "Movie",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiNGSti8ID59dXTpvScI18U7TStP_L9emhn1CxSm6jGc0dRtys8AnHIsUatMZ7uwyD7OeXTk_hLt0tsPD5FlHF5mtWkTydfTiLGbYjytz0_xNB0nCaoW2ffGeKzhOj8h8YsdTygFlLfjq7I/s800/kandou_movie_sad.png",
    "history": []
  },
  {
    "id": 100801,
    "category": CategoryCode.culture,
    "korWord": "음악",
    "engWord": "Music",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjCVKDzVPnGWMcwMSSfPLfUJxZgPgiZx1K9WACdwTziYVDpSYAQYXz2ihQXwuzgqdlztvtcJzU24l6ixx7KEDZxLJnbeveVo0YerUTOXmnm7wUFtro8kgIrKx4IZIwAqwYMTYXctgHNTso/s400/music_ongaku_kansyou.png",
    "history": []
  },
  {
    "id": 100802,
    "category": CategoryCode.culture,
    "korWord": "예술",
    "engWord": "Art",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh9GlpCkfct-Y5M1ZTupSd8nULlmqnLmC7iOYakM_71Tj_nRqgUHyG_lBgGjzwpGn3gju_IOo8NCvQU_VaBVVJznMFUq1224Nh2_-XiCNPQWi963O5ZXvEWOJZTCauQIcWgm5Yw8OaV6G_C/s400/kotowaza_enikaitamochi_man.png",
    "history": []
  },
  {
    "id": 100803,
    "category": CategoryCode.culture,
    "korWord": "공연",
    "engWord": "Performance",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhnQ7KJ3Y_ke3-7pMUGN8fEMQqVNGm5BN7XjDxihxI8mytkO1xGRv0WNSewz-BloVnzdsF1-bohHuSsYZw-gsj48vfc29OLW3FxyEcTEBOrJQaArfuHuabVcGThdUPuyCr9rzIBW1EMNj7N/s600/idol_woman_audience.png",
    "history": []
  },
  {
    "id": 100804,
    "category": CategoryCode.culture,
    "korWord": "축제",
    "engWord": "Festival",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhn9zhKrPUvOcCvcMDLG1VatweNAkvePjn0r3lJ3IY9yZon_hb4cwbu9Sn2EpxpUljxPVNDQ8t2gUCAL_KcglxfnLhN8g5NkDNTZqDkRL7T0e1j-BwhqKxFwscxibh8D0YKJf6zyR4tXnw/s500/bonodori.png",
    "history": []
  },
  //electronics
  {
    "id": 100900,
    "category": CategoryCode.electronics,
    "korWord": "스마트폰",
    "engWord": "Smartphone",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhg8VCG4utSW6fjOh1KgTRFMS8acgiTnqzhr_vBPL7cgYYWlrOvdflPZ0gbjm7iMFE48jopjNPtYx8J3yz3O31TOLvSV8lbquW0tFWixwa27pAkNNJuHuKANSTF2aARvksBM0R2LKm5MiOJ/s800/computer_smartphone1_icon.png",
    "history": []
  },
  {
    "id": 100901,
    "category": CategoryCode.electronics,
    "korWord": "노트북",
    "engWord": "Laptop",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhmre290czRSh5656NF6zfEWkaiTE8JD1VUabyoBvGIlkooxIU1JHSzNvXschHoL3RvvFh3vl-DuM55LNED94KJIqyjAhx5RJ_8KykqUyLnj8AKKrau8O1ubx6uDsbvwTJbBdHLR2qcnxGa/s800/tv_housou_sakka.png",
    "history": []
  },
  {
    "id": 100902,
    "category": CategoryCode.electronics,
    "korWord": "태블릿",
    "engWord": "Tablet",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhQPTbvFwWBNoV0r5hTFV1hm4m7S1LRCAnVQLHaHKT6YNd10mzFMk2_6W-7d6HlM8bwpvoWmXGPM7jpAgSA_Khz4iFuIOwMBn8KfwVMEG2mxn18_nB1nUMHf9xDyZpmUf9bASCEwlp1rvuL/s800/ekisyou_pen_tablet.png",
    "history": []
  },
  {
    "id": 100903,
    "category": CategoryCode.electronics,
    "korWord": "텔레비전",
    "engWord": "Television",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjEMxGPlTjkioYxzYAZZ_XtHf5w-qnx6zXmk9QZ2-mPLi-tz42N77_lvYtRFsZ9HZ0bhyGmrNHVK52Zp0Fwn9pMxP0LlVlAB1ygPMY1oezsQLc7ZO_qgqry8vsA28zDJi8u3HeYgYD1yk1b/s800/tv_girl_chikaku.png",
    "history": []
  },
  {
    "id": 100904,
    "category": CategoryCode.electronics,
    "korWord": "스피커",
    "engWord": "Speaker",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiPH0eNb7v_XiTdMTF9W5VIn8R9VWjgtESz-RVjn5vDQbQ5ti_fOVT8A5HXgyCvJA-Um7DA-D5xgPetgVmdfChsMiDL4vUYIgGwr6prnjSd8PWsFlghbKkxtZvNbXQdOXyuUEeLLAtHttRX/s800/music_360degree_speaker.png ",
    "history": []
  },
  //emotion
  {
    "id": 101000,
    "category": CategoryCode.emotion,
    "korWord": "기쁨",
    "engWord": "Joy",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZQemFCcyavo2bWhB8iEZPbZNUmoee2RfpzeaPWvZHxX_zj3O59Jtuq0uQstve-ivtv0l4mgWTj0H9nZcTjctz6sDTcqlOzeLZvlEGFG6L06aEaUQr7wBP26VNZ9t2I-9MXxP8PMQX_bQ/s800/present_happy_boy.png",
    "history": []
  },
  {
    "id": 101001,
    "category": CategoryCode.emotion,
    "korWord": "슬픔",
    "engWord": "Sadness",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhJydKK7xFYWnNNpqVdQMrm4bbDEvoDxfFLsf7FMmj-8kazA_kOEqwX8-1q5iz6cTJ0YhQP8JjJ3CIhPN0OxB6Bqe9A3EI771UCMmsM-ISqtMIrhZWrlqLMeaWjpN59l73StDzGy5e9Nst_/s1600/smartphone_broken_sad_man.png",
    "history": []
  },
  {
    "id": 101002,
    "category": CategoryCode.emotion,
    "korWord": "분노",
    "engWord": "Anger",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjDlDicqtaVmvJmEHMXv4yYaH74nrusiDT4nfnbA03-Lnv_VI-Rz-ukqme8hEGmiJzukEfyjBs0Ah7Px0_3jiTIUvzXRDN8m3n8KaaOeFxIbtPn67j2CRI9xUMxPOHaHiVn6iCrv7p07naD/s250/face_angry_woman5.png",
    "history": []
  },
  {
    "id": 101003,
    "category": CategoryCode.emotion,
    "korWord": "두려움",
    "engWord": "Fear",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgBtN2Q7ZC2ynSEycIQTIoYIMKsJzZK4rEjFp2E4x7Flsl1ICL-f7sfWhElI43Fwx4jKI4ZZDOqrwiSKc0ylrE_WRZzEvRjtin-aqrMUcFNA1b4gOvBgTuqZL3IFRU8i4bBFbNHcq32pZ8/s800/kyoufusyou_taijin.png",
    "history": []
  },
  {
    "id": 101004,
    "category": CategoryCode.emotion,
    "korWord": "놀람",
    "engWord": "Surprise",
    "image":
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgRyAy2FUlgoZDaVFD3Fxl-GAx8Cf9qCqWy-oBbDiZUPuhKe-lKWjnBB7CTkHC5FR6gsNid1ONx_G3a7XRgtJr6NZikrpA5zxZxbrUrbBIE1HcuoFIk36mLps8GwKkrrEWsF5r-iQb9HpbO/s800/cat2_2_surprise.png",
    "history": []
  }
];
