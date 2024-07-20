module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @* begin
    case ({c, d, a, b})
        4'b0100, 4'b0111: out = 1; //01,11
        4'b0000, 4'b0001: out = 0; //00
        4'b0010, 4'b0011, 4'b1000, 4'b1001, 4'b1010, 4'b1011, 4'b1100, 4'b1101: out = d; //d
        default: out = 1;
    endcase
end

endmodule
