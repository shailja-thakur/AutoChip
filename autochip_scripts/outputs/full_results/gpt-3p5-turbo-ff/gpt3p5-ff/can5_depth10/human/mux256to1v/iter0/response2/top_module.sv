module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    wire [3:0] out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15,
         out16, out17, out18, out19, out20, out21, out22, out23, out24, out25, out26, out27, out28, out29, out30, 
         out31, out32, out33, out34, out35, out36, out37, out38, out39, out40, out41, out42, out43, out44, out45, out46,
         out47, out48, out49, out50, out51, out52, out53, out54, out55, out56, out57, out58, out59, out60, out61, out62,
         out63, out64, out65, out66, out67, out68, out69, out70, out71, out72, out73, out74, out75, out76, out77, out78,
         out79, out80, out81, out82, out83, out84, out85, out86, out87, out88, out89, out90, out91, out92, out93, out94,
         out95, out96, out97, out98, out99, out100, out101, out102, out103, out104, out105, out106, out107, out108,
         out109, out110, out111, out112, out113, out114, out115, out116, out117, out118, out119, out120, out121,
         out122, out123, out124, out125, out126, out127, out128, out129, out130, out131, out132, out133, out134,
         out135, out136, out137, out138, out139, out140, out141, out142, out143, out144, out145, out146, out147,
         out148, out149, out150, out151, out152, out153, out154, out155, out156, out157, out158, out159, out160,
         out161, out162, out163, out164, out165, out166, out167, out168, out169, out170, out171, out172, out173,
         out174, out175, out176, out177, out178, out179, out180, out181, out182, out183, out184, out185, out186,
         out187, out188, out189, out190, out191, out192, out193, out194, out195, out196, out197, out198, out199,
         out200, out201, out202, out203, out204, out205, out206, out207, out208, out209, out210, out211, out212,
         out213, out214, out215, out216, out217, out218, out219, out220, out221, out222, out223, out224, out225,
         out226, out227, out228, out229, out230, out231, out232, out233, out234, out235, out236, out237, out238,
         out239, out240, out241, out242, out243, out244, out245, out246, out247, out248, out249, out250, out251,
         out252, out253, out254, out255, out256, out257, out258, out259, out260, out261, out262, out263, out264,
         out265, out266, out267, out268, out269, out270, out271, out272, out273, out274, out275, out276, out277,
         out278, out279, out280, out281, out282, out283, out284, out285, out286, out287, out288, out289, out290,
         out291, out292, out293, out294, out295, out296, out297, out298, out299, out300, out301, out302, out303,
         out304, out305, out306, out307, out308, out309, out310, out311, out312, out313, out314, out315, out316,
         out317, out318, out319, out320, out321, out322, out323, out324, out325, out326, out327, out328, out329,
         out330, out331, out332, out333, out334, out335, out336, out337, out338, out339, out340, out341, out342,
         out343, out344, out345, out346, out347, out348, out349, out350, out351, out352, out353, out354, out355,
         out356, out357, out358, out359, out360, out361, out362, out363, out364, out365, out366, out367, out368,
         out369, out370, out371, out372, out373, out374, out375, out376, out377, out378, out379, out380, out381,
         out382, out383, out384, out385, out386, out387, out388, out389, out390, out391, out392, out393, out394,
         out395, out396, out397, out398, out399, out400, out401, out402, out403, out404, out405, out406, out407,
         out408, out409, out410, out411, out412, out413, out414, out415, out416, out417, out418, out419, out420,
         out421, out422, out423, out424, out425, out426, out427, out428, out429, out430, out431, out432, out433,
         out434, out435, out436, out437, out438, out439, out440, out441, out442, out443, out444, out445, out446,
         out447, out448, out449, out450, out451, out452, out453, out454, out455, out456, out457, out458, out459,
         out460, out461, out462, out463, out464, out465, out466, out467, out468, out469, out470, out471, out472,
         out473, out474, out475, out476, out477, out478, out479, out480, out481, out482, out483, out484, out485,
         out486, out487, out488, out489, out490, out491, out492, out493, out494, out495, out496, out497, out498,
         out499, out500, out501, out502, out503, out504, out505, out506, out507, out508, out509, out510, out511,
         out512, out513, out514, out515, out516, out517, out518, out519, out520, out521, out522, out523, out524,
         out525, out526, out527, out528, out529, out530, out531, out532, out533, out534, out535, out536, out537,
         out538, out539, out540, out541, out542, out543, out544, out545, out546, out547, out548, out549, out550,
         out551, out552, out553, out554, out555, out556, out557, out558, out559, out560, out561, out562, out563,
         out564, out565, out566, out567, out568, out569, out570, out571, out572, out573, out574, out575, out576,
         out577, out578, out579, out580, out581, out582, out583, out584, out585, out586, out587, out588, out589,
         out590, out591, out592, out593, out594, out595, out596, out597, out598, out599, out600, out601, out602,
         out603, out604, out605, out606, out607, out608, out609, out610, out611, out612, out613, out614, out615,
         out616, out617, out618, out619, out620, out621, out622, out623, out624, out625, out626, out627, out628,
         out629, out630, out631, out632, out633, out634, out635, out636, out637, out638, out639, out640, out641,
         out642, out643, out644, out645, out646, out647, out648, out649, out650, out651, out652, out653, out654,
         out655, out656, out657, out658, out659, out660, out661, out662, out663, out664, out665, out666, out667,
         out668, out669, out670, out671, out672, out673, out674, out675, out676, out677, out678, out679, out680,
         out681, out682, out683, out684, out685, out686, out687, out688, out689, out690, out691, out692, out693,
         out694, out695, out696, out697, out698, out699, out700, out701, out702, out703, out704, out705, out706,
         out707, out708, out709, out710, out711, out712, out713, out714, out715, out716, out717, out718, out719,
         out720, out721, out722, out723, out724, out725, out726, out727, out728, out729, out730, out731, out732,
         out733, out734, out735, out736, out737, out738, out739, out740, out741, out742, out743, out744, out745,
         out746, out747, out748, out749, out750, out751, out752, out753, out754, out755, out756, out757, out758,
         out759, out760, out761, out762, out763, out764, out765, out766, out767, out768, out769, out770, out771,
         out772, out773, out774, out775, out776, out777, out778, out779, out780, out781, out782, out783, out784,
         out785, out786, out787, out788, out789, out790, out791, out792, out793, out794, out795, out796, out797,
         out798, out799, out800, out801, out802, out803, out804, out805, out806, out807, out808, out809, out810,
         out811, out812, out813, out814, out815, out816, out817, out818, out819, out820, out821, out822, out823,
         out824, out825, out826, out827, out828, out829, out830, out831, out832, out833, out834, out835, out836,
         out837, out838, out839, out840, out841, out842, out843, out844, out845, out846, out847, out848, out849,
         out850, out851, out852, out853, out854, out855, out856, out857, out858, out859, out860, out861, out862,
         out863, out864, out865, out866, out867, out868, out869, out870, out871, out872, out873, out874, out875,
         out876, out877, out878, out879, out880, out881, out882, out883, out884, out885, out886, out887, out888,
         out889, out890, out891, out892, out893, out894, out895, out896, out897, out898, out899, out900, out901,
         out902, out903, out904, out905, out906, out907, out908, out909, out910, out911, out912, out913, out914,
         out915, out916, out917, out918, out919, out920, out921, out922, out923, out924, out925, out926, out927,
         out928, out929, out930, out931, out932, out933, out934, out935, out936, out937, out938, out939, out940,
         out941, out942, out943, out944, out945, out946, out947, out948, out949, out950, out951, out952, out953,
         out954, out955, out956, out957, out958, out959, out960, out961, out962, out963, out964, out965, out966,
         out967, out968, out969, out970, out971, out972, out973, out974, out975, out976, out977, out978, out979,
         out980, out981, out982, out983, out984, out985, out986, out987, out988, out989, out990, out991, out992,
         out993, out994, out995, out996, out997, out998, out999, out1000, out1001, out1002, out1003, out1004,
         out1005, out1006, out1007, out1008, out1009, out1010, out1011, out1012, out1013, out1014, out1015,
         out1016, out1017, out1018, out1019, out1020, out1021, out1022, out1023;

    assign out = (sel == 0) ? {in[3:0]} :
                 (sel == 1) ? {in[7:4]} :
                 (sel == 2) ? {in[11:8]} :
                 (sel == 3) ? {in[15:12]} :
                 (sel == 4) ? {in[19:16]} :
                 (sel == 5) ? {in[23:20]} :
                 (sel == 6) ? {in[27:24]} :
                 (sel == 7) ? {in[31:28]} :
                 (sel == 8) ? {in[35:32]} :
                 (sel == 9) ? {in[39:36]} :
                 (sel == 10) ? {in[43:40]} :
                 (sel == 11) ? {in[47:44]} :
                 (sel == 12) ? {in[51:48]} :
                 (sel == 13) ? {in[55:52]} :
                 (sel == 14) ? {in[59:56]} :
                 (sel == 15) ? {in[63:60]} :
                 (sel == 16) ? {in[67:64]} :
                 (sel == 17) ? {in[71:68]} :
                 (sel == 18) ? {in[75:72]} :
                 (sel == 19) ? {in[79:76]} :
                 (sel == 20) ? {in[83:80]} :
                 (sel == 21) ? {in[87:84]} :
                 (sel == 22) ? {in[91:88]} :
                 (sel == 23) ? {in[95:92]} :
                 (sel == 24) ? {in[99:96]} :
                 (sel == 25) ? {in[103:100]} :
                 (sel == 26) ? {in[107:104]} :
                 (sel == 27) ? {in[111:108]} :
                 (sel == 28) ? {in[115:112]} :
                 (sel == 29) ? {in[119:116]} :
                 (sel == 30) ? {in[123:120]} :
                 (sel == 31) ? {in[127:124]} :
                 (sel == 32) ? {in[131:128]} :
                 (sel == 33) ? {in[135:132]} :
                 (sel == 34) ? {in[139:136]} :
                 (sel == 35) ? {in[143:140]} :
                 (sel == 36) ? {in[147:144]} :
                 (sel == 37) ? {in[151:148]} :
                 (sel == 38) ? {in[155:152]} :
                 (sel == 39) ? {in[159:156]} :
                 (sel == 40) ? {in[163:160]} :
                 (sel == 41) ? {in[167:164]} :
                 (sel == 42) ? {in[171:168]} :
                 (sel == 43) ? {in[175:172]} :
                 (sel == 44) ? {in[179:176]} :
                 (sel == 45) ? {in[183:180]} :
                 (sel == 46) ? {in[187:184]} :
                 (sel == 47) ? {in[191:188]} :
                 (sel == 48) ? {in[195:192]} :
                 (sel == 49) ? {in[199:196]} :
                 (sel == 50) ? {in[203:200]} :
                 (sel == 51) ? {in[207:204]} :
                 (sel == 52) ? {in[211:208]} :
                 (sel == 53) ? {in[215:212]} :
                 (sel == 54) ? {in[219:216]} :
                 (sel == 55) ? {in[223:220]} :
                 (sel == 56) ? {in[227:224]} :
                 (sel == 57) ? {in[231:228]} :
                 (sel == 58) ? {in[235:232]} :
                 (sel == 59) ? {in[239:236]} :
                 (sel == 60) ? {in[243:240]} :
                 (sel == 61) ? {in[247:244]} :
                 (sel == 62) ? {in[251:248]} :
                 (sel == 63) ? {in[255:252]} :
                 (sel == 64) ? {in[259:256]} :
                 (sel == 65) ? {in[263:260]} :
                 (sel == 66) ? {in[267:264]} :
                 (sel == 67) ? {in[271:268]} :
                 (sel == 68) ? {in[275:272]} :
                 (sel == 69) ? {in[279:276]} :
                 (sel == 70) ? {in[283:280]} :
                 (sel == 71) ? {in[287:284]} :
                 (sel == 72) ? {in[291:288]} :
                 (sel == 73) ? {in[295:292]} :
                 (sel == 74) ? {in[299:296]} :
                 (sel == 75) ? {in[303:300]} :
                 (sel == 76) ? {in[307:304]} :
                 (sel == 77) ? {in[311:308]} :
                 (sel == 78) ? {in[315:312]} :
                 (sel == 79) ? {in[319:316]} :
                 (sel == 80) ? {in[323:320]} :
                 (sel == 81) ? {in[327:324]} :
                 (sel == 82) ? {in[331:328]} :
                 (sel == 83) ? {in[335:332]} :
                 (sel == 84) ? {in[339:336]} :
                 (sel == 85) ? {in[343:340]} :
                 (sel == 86) ? {in[347:344]} :
                 (sel == 87) ? {in[351:348]} :
                 (sel == 88) ? {in[355:352]} :
                 (sel == 89) ? {in[359:356]} :
                 (sel == 90) ? {in[363:360]} :
                 (sel == 91) ? {in[367:364]} :
                 (sel == 92) ? {in[371:368]} :
                 (sel == 93) ? {in[375:372]} :
                 (sel == 94) ? {in[379:376]} :
                 (sel == 95) ? {in[383:380]} :
                 (sel == 96) ? {in[387:384]} :
                 (sel == 97) ? {in[391:388]} :
                 (sel == 98) ? {in[395:392]} :
                 (sel == 99) ? {in[399:396]} :
                 (sel == 100) ? {in[403:400]} :
                 (sel == 101) ? {in[407:404]} :
                 (sel == 102) ? {in[411:408]} :
                 (sel == 103) ? {in[415:412]} :
                 (sel == 104) ? {in[419:416]} :
                 (sel == 105) ? {in[423:420]} :
                 (sel == 106) ? {in[427:424]} :
                 (sel == 107) ? {in[431:428]} :
                 (sel == 108) ? {in[435:432]} :
                 (sel == 109) ? {in[439:436]} :
                 (sel == 110) ? {in[443:440]} :
                 (sel == 111) ? {in[447:444]} :
                 (sel == 112) ? {in[451:448]} :
                 (sel == 113) ? {in[455:452]} :
                 (sel == 114) ? {in[459:456]} :
                 (sel == 115) ? {in[463:460]} :
                 (sel == 116) ? {in[467:464]} :
                 (sel == 117) ? {in[471:468]} :
                 (sel == 118) ? {in[475:472]} :
                 (sel == 119) ? {in[479:476]} :
                 (sel == 120) ? {in[483:480]} :
                 (sel == 121) ? {in[487:484]} :
                 (sel == 122) ? {in[491:488]} :
                 (sel == 123) ? {in[495:492]} :
                 (sel == 124) ? {in[499:496]} :
                 (sel == 125) ? {in[503:500]} :
                 (sel == 126) ? {in[507:504]} :
                 (sel == 127) ? {in[511:508]} :
                 (sel == 128) ? {in[515:512]} :
                 (sel == 129) ? {in[519:516]} :
                 (sel == 130) ? {in[523:520]} :
                 (sel == 131) ? {in[527:524]} :
                 (sel == 132) ? {in[531:528]} :
                 (sel == 133) ? {in[535:532]} :
                 (sel == 134) ? {in[539:536]} :
                 (sel == 135) ? {in[543:540]} :
                 (sel == 136) ? {in[547:544]} :
                 (sel == 137) ? {in[551:548]} :
                 (sel == 138) ? {in[555:552]} :
                 (sel == 139) ? {in[559:556]} :
                 (sel == 140) ? {in[563:560]} :
                 (sel == 141) ? {in[567:564]} :
                 (sel == 142) ? {in[571:568]} :
                 (sel == 143) ? {in[575:572]} :
                 (sel == 144) ? {in[579:576]} :
                 (sel == 145) ? {in[583:580]} :
                 (sel == 146) ? {in[587:584]} :
                 (sel == 147) ? {in[591:588]} :
                 (sel == 148) ? {in[595:592]} :
                 (sel == 149) ? {in[599:596]} :
                 (sel == 150) ? {in[603:600]} :
                 (sel == 151) ? {in[607:604]} :
                 (sel == 152) ? {in[611:608]} :
                 (sel == 153) ? {in[615:612]} :
                 (sel == 154) ? {in[619:616]} :
                 (sel == 155) ? {in[623:620]} :
                 (sel == 156) ? {in[627:624]} :
                 (sel == 157) ? {in[631:628]} :
                 (sel == 158) ? {in[635:632]} :
                 (sel == 159) ? {in[639:636]} :
                 (sel == 160) ? {in[643:640]} :
                 (sel == 161) ? {in[647:644]} :
                 (sel == 162) ? {in[651:648]} :
                 (sel == 163) ? {in[655:652]} :
                 (sel == 164) ? {in[659:656]} :
                 (sel == 165) ? {in[663:660]} :
                 (sel == 166) ? {in[667:664]} :
                 (sel == 167) ? {in[671:668]} :
                 (sel == 168) ? {in[675:672]} :
                 (sel == 169) ? {in[679:676]} :
                 (sel == 170) ? {in[683:680]} :
                 (sel == 171) ? {in[687:684]} :
                 (sel == 172) ? {in[691:688]} :
                 (sel == 173) ? {in[695:692]} :
                 (sel == 174) ? {in[699:696]} :
                 (sel == 175) ? {in[703:700]} :
                 (sel == 176) ? {in[707:704]} :
                 (sel == 177) ? {in[711:708]} :
                 (sel == 178) ? {in[715:712]} :
                 (sel == 179) ? {in[719:716]} :
                 (sel == 180) ? {in[723:720]} :
                 (sel == 181) ? {in[727:724]} :
                 (sel == 182) ? {in[731:728]} :
                 (sel == 183) ? {in[735:732]} :
                 (sel == 184) ? {in[739:736]} :
                 (sel == 185) ? {in[743:740]} :
                 (sel == 186) ? {in[747:744]} :
                 (sel == 187) ? {in[751:748]} :
                 (sel == 188) ? {in[755:752]} :
                 (sel == 189) ? {in[759:756]} :
                 (sel == 190) ? {in[763:760]} :
                 (sel == 191) ? {in[767:764]} :
                 (sel == 192) ? {in[771:768]} :
                 (sel == 193) ? {in[775:772]} :
                 (sel == 194) ? {in[779:776]} :
                 (sel == 195) ? {in[783:780]} :
                 (sel == 196) ? {in[787:784]} :
                 (sel == 197) ? {in[791:788]} :
                 (sel == 198) ? {in[795:792]} :
                 (sel == 199) ? {in[799:796]} :
                 (sel == 200) ? {in[803:800]} :
                 (sel == 201) ? {in[807:804]} :
                 (sel == 202) ? {in[811:808]} :
                 (sel == 203) ? {in[815:812]} :
                 (sel == 204) ? {in[819:816]} :
                 (sel == 205) ? {in[823:820]} :
                 (sel == 206) ? {in[827:824]} :
                 (sel == 207) ? {in[831:828]} :
                 (sel == 208) ? {in[835:832]} :
                 (sel == 209) ? {in[839:836]} :
                 (sel == 210) ? {in[843:840]} :
                 (sel == 211) ? {in[847:844]} :
                 (sel == 212) ? {in[851:848]} :
                 (sel == 213) ? {in[855:852]} :
                 (sel == 214) ? {in[859:856]} :
                 (sel == 215) ? {in[863:860]} :
                 (sel == 216) ? {in[867:864]} :
                 (sel == 217) ? {in[871:868]} :
                 (sel == 218) ? {in[875:872]} :
                 (sel == 219) ? {in[879:876]} :
                 (sel == 220) ? {in[883:880]} :
                 (sel == 221) ? {in[887:884]} :
                 (sel == 222) ? {in[891:888]} :
                 (sel == 223) ? {in[895:892]} :
                 (sel == 224) ? {in[899:896]} :
                 (sel == 225) ? {in[903:900]} :
                 (sel == 226) ? {in[907:904]} :
                 (sel == 227) ? {in[911:908]} :
                 (sel == 228) ? {in[915:912]} :
                 (sel == 229) ? {in[919:916]} :
                 (sel == 230) ? {in[923:920]} :
                 (sel == 231) ? {in[927:924]} :
                 (sel == 232) ? {in[931:928]} :
                 (sel == 233) ? {in[935:932]} :
                 (sel == 234) ? {in[939:936]} :
                 (sel == 235) ? {in[943:940]} :
                 (sel == 236) ? {in[947:944]} :
                 (sel == 237) ? {in[951:948]} :
                 (sel == 238) ? {in[955:952]} :
                 (sel == 239) ? {in[959:956]} :
                 (sel == 240) ? {in[963:960]} :
                 (sel == 241) ? {in[967:964]} :
                 (sel == 242) ? {in[971:968]} :
                 (sel == 243) ? {in[975:972]} :
                 (sel == 244) ? {in[979:976]} :
                 (sel == 245) ? {in[983:980]} :
                 (sel == 246) ? {in[987:984]} :
                 (sel == 247) ? {in[991:988]} :
                 (sel == 248) ? {in[995:992]} :
                 (sel == 249) ? {in[999:996]} :
                 (sel == 250) ? {in[1003:1000]} :
                 (sel == 251) ? {in[1007:1004]} :
                 (sel == 252) ? {in[1011:1008]} :
                 (sel == 253) ? {in[1015:1012]} :
                 (sel == 254) ? {in[1019:1016]} :
                 (sel == 255) ? {in[1023:1020]} :
                 4'bZZZZ;

endmodule
