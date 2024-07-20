module top_module (
	input [4:1] x,
	output logic f
);

// Karnaugh map:
//        x[1]x[2]
// x[3]x[4]   00 01 11 10
//  00 | d | 0 | d | d |
//  01 | 0 | d | 1 | 0 |
//  11 | 1 | 1 | d | d |
//  10 | 1 | 1 | 0 | d |

// Truth table:
//   x[4] x[3] x[2] x[1] | f
//   ---------------------
//     0    0    0    0  | d
//     0    0    0    1  | 0
//     0    0    1    0  | d
//     0    0    1    1  | d
//     0    1    0    0  | 0
//     0    1    0    1  | d
//     0    1    1    0  | 1
//     0    1    1    1  | 0
//     1    0    0    0  | 1
//     1    0    0    1  | 1
//     1    0    1    0  | d
//     1    0    1    1  | d
//     1    1    0    0  | 1
//     1    1    0    1  | 1
//     1    1    1    0  | d
//     1    1    1    1  | d

// Implement the function f:

// Assigning the output values based on the Karnaugh map:
always_comb begin
	case (x)
		4'b0000: f = 1'b1; // Corrected
		4'b0001: f = 1'b0;
		4'b0010: f = 1'b1; // Corrected
		4'b0011: f = 1'b1; // Corrected
		4'b0100: f = 1'b0;
		4'b0101: f = 1'b1; // Corrected
		4'b0110: f = 1'b1;
		4'b0111: f = 1'b0;
		4'b1000: f = 1'b1;
		4'b1001: f = 1'b1;
		4'b1010: f = 1'b0; // Corrected
		4'b1011: f = 1'b0; // Corrected
		4'b1100: f = 1'b1;
		4'b1101: f = 1'b1;
		4'b1110: f = 1'b0; // Corrected
		4'b1111: f = 1'b0; // Corrected
	endcase
end

endmodule
