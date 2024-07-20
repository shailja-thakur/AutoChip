module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(a or b or c or d) begin
    case({c, d, a, b})
        // 00 01 11 10
        // |  d | 0 | 1 | 1 |
        // |  0 | 0 | d | d |
        // |  0 | 1 | 1 | 1 |
        // |  0 | 1 | 1 | 1 |
        4'b0000, 4'b0100, 4'b1110, 4'b1000: out = 1;

        // |  d | 0 | 1 | 1 |
        // |  0 | 0 | d | d |
        // |  0 | 0 | d | d |
        // |  0 | 0 | d | d |
        4'b0001, 4'b0010, 4'b0011, 4'b0110, 4'b0111: out = 0;

        // |  d | 0 | 1 | 1 |
        // |  0 | 0 | d | d |
        // |  0 | 0 | d | d |
        // |  0 | 1 | 1 | 1 |
        4'b0101: out = d;

        // |  d | 0 | 1 | 1 |
        // |  0 | 0 | d | d |
        // |  0 | 1 | 1 | 1 |
        // |  0 | 1 | 1 | 1 |
        4'b1100, 4'b1101, 4'b1111: out = 0;

        default: out = 0;
    endcase
end

endmodule
