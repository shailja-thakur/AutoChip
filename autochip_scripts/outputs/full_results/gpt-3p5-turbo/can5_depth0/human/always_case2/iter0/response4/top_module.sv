module top_module (
	input [3:0] in,
	output reg [1:0] pos
);

	always @* begin
		case (in)
			4'b0001: pos = 2'b00; // position 0
			4'b0010: pos = 2'b01; // position 1
			4'b0100: pos = 2'b10; // position 2
			4'b1000: pos = 2'b11; // position 3
			default: pos = 2'b00; // no high bit, output zero
		endcase
	end

endmodule
