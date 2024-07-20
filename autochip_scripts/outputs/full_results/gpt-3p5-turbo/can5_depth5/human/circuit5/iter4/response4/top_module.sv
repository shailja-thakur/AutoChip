module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);
	always @(*) begin
		case({c, d})
			4'b00: q = b;
			4'b01: q = e;
			4'b10: q = a;
			default: q = f;  // Changed from q = d; to q = f;
		endcase
	end
endmodule
