module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @(*) begin
		case (a)
			3'b000: q = 16'h1232; // 4658
			3'b001: q = 16'haf60; // 44768
			3'b010: q = 16'h27dc; // 10196
			3'b011: q = 16'h5a0e; // 23054
			3'b100: q = 16'h205e; // 8294
			3'b101: q = 16'h64de; // 25806
			3'b110: q = 16'hc536; // 50470
			3'b111: q = 16'h2f19; // 12057
			default: q = 16'h0000; // Default case
		endcase
	end

endmodule
