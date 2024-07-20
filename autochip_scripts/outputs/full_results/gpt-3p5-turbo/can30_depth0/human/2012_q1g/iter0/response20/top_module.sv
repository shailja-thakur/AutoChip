module top_module (
	input [4:1] x,
	output logic f
);

// Truth table for f
//       x[1]x[2]
// x[3]x[4]   00 01 11 10
//  00 | 1 | 0 | 0 | 1 |
//  01 | 0 | 0 | 0 | 0 |
//  11 | 1 | 1 | 1 | 0 |
//  10 | 1 | 1 | 0 | 1 |

// Let's implement the function based on the truth table

always_comb begin
	case (x)
		4'b0000: f = 1;
		4'b0010: f = 0;
		4'b1110: f = 1;
		4'b1010: f = 1;
		default: f = 0;
	endcase
end

endmodule
