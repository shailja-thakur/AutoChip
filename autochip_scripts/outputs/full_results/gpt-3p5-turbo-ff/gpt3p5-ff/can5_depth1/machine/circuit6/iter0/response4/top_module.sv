module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @(a) begin
		case (a)
			3'b000: q = 16'h1232;
			3'b001: q = 16'hAF60;
			3'b010: q = 16'h27A4;
			3'b011: q = 16'h5A76;
			3'b100: q = 16'h206A;
			3'b101: q = 16'h64DE;
			3'b110: q = 16'hC50E;
			3'b111: q = 16'h2F19;
			default: q = 16'h0; // Add a default case to handle undefined values of 'a'
		endcase
	end

endmodule
