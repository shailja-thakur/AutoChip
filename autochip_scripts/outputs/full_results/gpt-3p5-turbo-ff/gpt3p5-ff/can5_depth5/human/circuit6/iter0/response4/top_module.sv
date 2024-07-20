module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

always @* begin
    case(a)
        3'b000: q = 16'b1232;
        3'b001: q = 16'baee0;
        3'b010: q = 16'b27d4;
        3'b011: q = 16'b5a0e;
        3'b100: q = 16'b2066;
        3'b101: q = 16'b64ce;
        3'b110: q = 16'bc526;
        3'b111: q = 16'b2f19;
        default: q = 16'b0;
    endcase
end

endmodule
