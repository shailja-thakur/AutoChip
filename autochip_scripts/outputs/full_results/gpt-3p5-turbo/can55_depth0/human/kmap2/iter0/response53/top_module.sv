module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Implement the circuit described by the Karnaugh map below.

//        ab
// cd   00 01 11 10
//  00 | 1 | 1 | 0 | 1 |
//  01 | 1 | 0 | 0 | 1 |
//  11 | 0 | 1 | 1 | 1 |
//  10 | 1 | 1 | 0 | 0 |

wire w1, w2, w3, w4;

and gate1 (w1, a, ~b);
and gate2 (w2, ~a, b);
and gate3 (w3, ~a, ~c, d);
and gate4 (w4, a, c, ~d);

or out_gate (out, w1, w2, w3, w4);

endmodule
