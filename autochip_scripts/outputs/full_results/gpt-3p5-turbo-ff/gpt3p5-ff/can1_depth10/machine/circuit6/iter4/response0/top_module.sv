module top_module (
	input [2:0] a,
	output reg [15:0] q
);
	always @(*) begin
		case(a)
			3'b000: q = 16'b0100100110111010;
			3'b001: q = 16'b1010111100110000;
			3'b010: q = 16'b0010110001100100;
			3'b011: q = 16'b0101101100111010;
			3'b100: q = 16'b0010000100011010;
			3'b101: q = 16'b0110011110100110;
			3'b110: q = 16'b1100001100101110;
			3'b111: q = 16'b0010110001111001;
			default: q = 16'b0000000000000000;
		endcase
	end

	// Additional code to handle unknown values of 'a'
	always @(a) begin
		if (a > 7) begin
			$display("Warning: Unknown value of 'a', assigning 16'b0000000000000000 to 'q'");
			q = 16'b0000000000000000;
		end
	end
endmodule
