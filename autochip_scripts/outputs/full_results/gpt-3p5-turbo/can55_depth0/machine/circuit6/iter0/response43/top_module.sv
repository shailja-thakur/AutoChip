module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

always @(*) begin
	case(a)
		3'b000: q = 16'h1232;
		3'b001: q = 16'hAEB0;
		3'b010: q = 16'h27EC;
		3'b011: q = 16'h59A6;
		3'b100: q = 16'h205A;
		3'b101: q = 16'h647E;
		3'b110: q = 16'hC4DE;
		3'b111: q = 16'h2F49;
	endcase
end

endmodule
