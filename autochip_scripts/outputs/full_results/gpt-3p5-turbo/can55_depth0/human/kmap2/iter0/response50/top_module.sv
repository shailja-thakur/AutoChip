module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	// Karnaugh Map Truth Table
	//       ab
	// cd   00 01 11 10
	//  00 |  1   1   0   1  |
	//  01 |  1   0   0   1  |
	//  11 |  0   1   1   1  |
	//  10 |  1   1   0   0  |

	wire case1, case2, case3, case4;
	
	and(case1, ~(a|b|c|d), ~(a|^b|i|d), ~(^a|^b|^c|d));
	and(case2, ~(a|b|c|d), ~(a|b|i|d), ~(^a|^b|^c|d));
	and(case3, ~(a|b|c|d), ~(a|^b|i|d), ^(a|^b|^c|d));
	and(case4, ~(a|b|c|d), ~(a|b|i|d), ^(a|^b|^c|d));
	
	or(out, case1, case2, case3, case4);

endmodule
