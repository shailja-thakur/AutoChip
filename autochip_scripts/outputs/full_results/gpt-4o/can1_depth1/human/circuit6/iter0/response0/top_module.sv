module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	// Implement the combinational logic based on provided waveform data
	always @(*) begin
		case (a)
			3'b000: q = 16'h1232; // a = 0
			3'b001: q = 16'haee0; // a = 1
			3'b010: q = 16'h27d4; // a = 2
			3'b011: q = 16'h5a0e; // a = 3
			3'b100: q = 16'h2066; // a = 4
			3'b101: q = 16'h64ce; // a = 5
			3'b110: q = 16'hc526; // a = 6
			3'b111: q = 16'h2f19; // a = 7
			default: q = 16'h0000; // default case
		endcase
	end

endmodule
