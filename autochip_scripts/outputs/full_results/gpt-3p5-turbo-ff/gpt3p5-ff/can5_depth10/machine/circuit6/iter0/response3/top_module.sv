module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @(*) begin
		case(a)
			3'b000: q = 16'h1232;
			3'b001: q = 16'hAE10;
			3'b010: q = 16'h284C;
			3'b011: q = 16'h59CE;
			3'b100: q = 16'h206A;
			3'b101: q = 16'h641A;
			3'b110: q = 16'hC52E;
			3'b111: q = 16'h2EE9;
		endcase
	end

endmodule
