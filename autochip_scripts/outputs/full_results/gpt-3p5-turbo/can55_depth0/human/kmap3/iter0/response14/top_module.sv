module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

// Implement the circuit described by the Karnaugh map below.

//        ab
// cd   01 00 10 11
//  00 | d | 0 | 1 | 1 |
//  01 | 0 | 0 | d | d |
//  11 | 0 | 1 | 1 | 1 |
//  10 | 0 | 1 | 1 | 1 |

always @(*) begin
    case ({c, d, a, b})
        4'b0xx1 : out = 1; // d=don't care
        4'b0101 : out = 1;
        4'b0110 : out = 1;
        4'b0111 : out = 1;
        4'b111x : out = 1; // d=don't care
        4'b1001 : out = 1;
        4'b1010 : out = 1;
        4'b1011 : out = 1;
        default : out = 0;
    endcase
end

endmodule
