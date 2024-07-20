module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Create a wire to store the selected bits from the input
	wire [3:0] selected_bits;

	// Instantiate the multiplexer
	multiplexer mux_inst (
		.in(in),
		.sel(sel),
		.out(selected_bits)
	);

	// Assign the output of the multiplexer to the module's output
	assign out = selected_bits;

	// Define the multiplexer module
	module multiplexer (
		input [1023:0] in,
		input [7:0] sel,
		output [3:0] out
	);
		// Create a wire to store the selected bits
		wire [3:0] selected_bits;
		
		// Use a case statement to select the bits based on the sel input
		always @(*) begin
			case(sel)
				0: selected_bits = in[3:0];
				1: selected_bits = in[7:4];
				2: selected_bits = in[11:8];
				3: selected_bits = in[15:12];
				4: selected_bits = in[19:16];
				5: selected_bits = in[23:20];
				6: selected_bits = in[27:24];
				7: selected_bits = in[31:28];
				8: selected_bits = in[35:32];
				9: selected_bits = in[39:36];
				10: selected_bits = in[43:40];
				11: selected_bits = in[47:44];
				12: selected_bits = in[51:48];
				13: selected_bits = in[55:52];
				14: selected_bits = in[59:56];
				15: selected_bits = in[63:60];
				16: selected_bits = in[67:64];
				17: selected_bits = in[71:68];
				18: selected_bits = in[75:72];
				19: selected_bits = in[79:76];
				20: selected_bits = in[83:80];
				21: selected_bits = in[87:84];
				22: selected_bits = in[91:88];
				23: selected_bits = in[95:92];
				24: selected_bits = in[99:96];
				25: selected_bits = in[103:100];
				26: selected_bits = in[107:104];
				27: selected_bits = in[111:108];
				28: selected_bits = in[115:112];
				29: selected_bits = in[119:116];
				30: selected_bits = in[123:120];
				31: selected_bits = in[127:124];
				32: selected_bits = in[131:128];
				33: selected_bits = in[135:132];
				34: selected_bits = in[139:136];
				35: selected_bits = in[143:140];
				36: selected_bits = in[147:144];
				37: selected_bits = in[151:148];
				38: selected_bits = in[155:152];
				39: selected_bits = in[159:156];
				40: selected_bits = in[163:160];
				41: selected_bits = in[167:164];
				42: selected_bits = in[171:168];
				43: selected_bits = in[175:172];
				44: selected_bits = in[179:176];
				45: selected_bits = in[183:180];
				46: selected_bits = in[187:184];
				47: selected_bits = in[191:188];
				48: selected_bits = in[195:192];
				49: selected_bits = in[199:196];
				50: selected_bits = in[203:200];
				51: selected_bits = in[207:204];
				52: selected_bits = in[211:208];
				53: selected_bits = in[215:212];
				54: selected_bits = in[219:216];
				55: selected_bits = in[223:220];
				56: selected_bits = in[227:224];
				57: selected_bits = in[231:228];
				58: selected_bits = in[235:232];
				59: selected_bits = in[239:236];
				60: selected_bits = in[243:240];
				61: selected_bits = in[247:244];
				62: selected_bits = in[251:248];
				63: selected_bits = in[255:252];
				64: selected_bits = in[259:256];
				65: selected_bits = in[263:260];
				66: selected_bits = in[267:264];
				67: selected_bits = in[271:268];
				68: selected_bits = in[275:272];
				69: selected_bits = in[279:276];
				70: selected_bits = in[283:280];
				71: selected_bits = in[287:284];
				72: selected_bits = in[291:288];
				73: selected_bits = in[295:292];
				74: selected_bits = in[299:296];
				75: selected_bits = in[303:300];
				76: selected_bits = in[307:304];
				77: selected_bits = in[311:308];
				78: selected_bits = in[315:312];
				79: selected_bits = in[319:316];
				80: selected_bits = in[323:320];
				81: selected_bits = in[327:324];
				82: selected_bits = in[331:328];
				83: selected_bits = in[335:332];
				84: selected_bits = in[339:336];
				85: selected_bits = in[343:340];
				86: selected_bits = in[347:344];
				87: selected_bits = in[351:348];
				88: selected_bits = in[355:352];
				89: selected_bits = in[359:356];
				90: selected_bits = in[363:360];
				91: selected_bits = in[367:364];
				92: selected_bits = in[371:368];
				93: selected_bits = in[375:372];
				94: selected_bits = in[379:376];
				95: selected_bits = in[383:380];
				96: selected_bits = in[387:384];
				97: selected_bits = in[391:388];
				98: selected_bits = in[395:392];
				99: selected_bits = in[399:396];
				100: selected_bits = in[403:400];
				101: selected_bits = in[407:404];
				102: selected_bits = in[411:408];
				103: selected_bits = in[415:412];
				104: selected_bits = in[419:416];
				105: selected_bits = in[423:420];
				106: selected_bits = in[427:424];
				107: selected_bits = in[431:428];
				108: selected_bits = in[435:432];
				109: selected_bits = in[439:436];
				110: selected_bits = in[443:440];
				111: selected_bits = in[447:444];
				112: selected_bits = in[451:448];
				113: selected_bits = in[455:452];
				114: selected_bits = in[459:456];
				115: selected_bits = in[463:460];
				116: selected_bits = in[467:464];
				117: selected_bits = in[471:468];
				118: selected_bits = in[475:472];
				119: selected_bits = in[479:476];
				120: selected_bits = in[483:480];
				121: selected_bits = in[487:484];
				122: selected_bits = in[491:488];
				123: selected_bits = in[495:492];
				124: selected_bits = in[499:496];
				125: selected_bits = in[503:500];
				126: selected_bits = in[507:504];
				127: selected_bits = in[511:508];
				128: selected_bits = in[515:512];
				129: selected_bits = in[519:516];
				130: selected_bits = in[523:520];
				131: selected_bits = in[527:524];
				132: selected_bits = in[531:528];
				133: selected_bits = in[535:532];
				134: selected_bits = in[539:536];
				135: selected_bits = in[543:540];
				136: selected_bits = in[547:544];
				137: selected_bits = in[551:548];
				138: selected_bits = in[555:552];
				139: selected_bits = in[559:556];
				140: selected_bits = in[563:560];
				141: selected_bits = in[567:564];
				142: selected_bits = in[571:568];
				143: selected_bits = in[575:572];
				144: selected_bits = in[579:576];
				145: selected_bits = in[583:580];
				146: selected_bits = in[587:584];
				147: selected_bits = in[591:588];
				148: selected_bits = in[595:592];
				149: selected_bits = in[599:596];
				150: selected_bits = in[603:600];
				151: selected_bits = in[607:604];
				152: selected_bits = in[611:608];
				153: selected_bits = in[615:612];
				154: selected_bits = in[619:616];
				155: selected_bits = in[623:620];
				156: selected_bits = in[627:624];
				157: selected_bits = in[631:628];
				158: selected_bits = in[635:632];
				159: selected_bits = in[639:636];
				160: selected_bits = in[643:640];
				161: selected_bits = in[647:644];
				162: selected_bits = in[651:648];
				163: selected_bits = in[655:652];
				164: selected_bits = in[659:656];
				165: selected_bits = in[663:660];
				166: selected_bits = in[667:664];
				167: selected_bits = in[671:668];
				168: selected_bits = in[675:672];
				169: selected_bits = in[679:676];
				170: selected_bits = in[683:680];
				171: selected_bits = in[687:684];
				172: selected_bits = in[691:688];
				173: selected_bits = in[695:692];
				174: selected_bits = in[699:696];
				175: selected_bits = in[703:700];
				176: selected_bits = in[707:704];
				177: selected_bits = in[711:708];
				178: selected_bits = in[715:712];
				179: selected_bits = in[719:716];
				180: selected_bits = in[723:720];
				181: selected_bits = in[727:724];
				182: selected_bits = in[731:728];
				183: selected_bits = in[735:732];
				184: selected_bits = in[739:736];
				185: selected_bits = in[743:740];
				186: selected_bits = in[747:744];
				187: selected_bits = in[751:748];
				188: selected_bits = in[755:752];
				189: selected_bits = in[759:756];
				190: selected_bits = in[763:760];
				191: selected_bits = in[767:764];
				192: selected_bits = in[771:768];
				193: selected_bits = in[775:772];
				194: selected_bits = in[779:776];
				195: selected_bits = in[783:780];
				196: selected_bits = in[787:784];
				197: selected_bits = in[791:788];
				198: selected_bits = in[795:792];
				199: selected_bits = in[799:796];
				200: selected_bits = in[803:800];
				201: selected_bits = in[807:804];
				202: selected_bits = in[811:808];
				203: selected_bits = in[815:812];
				204: selected_bits = in[819:816];
				205: selected_bits = in[823:820];
				206: selected_bits = in[827:824];
				207: selected_bits = in[831:828];
				208: selected_bits = in[835:832];
				209: selected_bits = in[839:836];
				210: selected_bits = in[843:840];
				211: selected_bits = in[847:844];
				212: selected_bits = in[851:848];
				213: selected_bits = in[855:852];
				214: selected_bits = in[859:856];
				215: selected_bits = in[863:860];
				216: selected_bits = in[867:864];
				217: selected_bits = in[871:868];
				218: selected_bits = in[875:872];
				219: selected_bits = in[879:876];
				220: selected_bits = in[883:880];
				221: selected_bits = in[887:884];
				222: selected_bits = in[891:888];
				223: selected_bits = in[895:892];
				224: selected_bits = in[899:896];
				225: selected_bits = in[903:900];
				226: selected_bits = in[907:904];
				227: selected_bits = in[911:908];
				228: selected_bits = in[915:912];
				229: selected_bits = in[919:916];
				230: selected_bits = in[923:920];
				231: selected_bits = in[927:924];
				232: selected_bits = in[931:928];
				233: selected_bits = in[935:932];
				234: selected_bits = in[939:936];
				235: selected_bits = in[943:940];
				236: selected_bits = in[947:944];
				237: selected_bits = in[951:948];
				238: selected_bits = in[955:952];
				239: selected_bits = in[959:956];
				240: selected_bits = in[963:960];
				241: selected_bits = in[967:964];
				242: selected_bits = in[971:968];
				243: selected_bits = in[975:972];
				244: selected_bits = in[979:976];
				245: selected_bits = in[983:980];
				246: selected_bits = in[987:984];
				247: selected_bits = in[991:988];
				248: selected_bits = in[995:992];
				249: selected_bits = in[999:996];
				250: selected_bits = in[1003:1000];
				251: selected_bits = in[1007:1004];
				252: selected_bits = in[1011:1008];
				253: selected_bits = in[1015:1012];
				254: selected_bits = in[1019:1016];
				255: selected_bits = in[1023:1020];
				default: selected_bits = 4'b0;
			endcase
		end

	endmodule
