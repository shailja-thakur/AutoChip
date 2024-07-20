module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

	reg [1:0] flip_flop;

	always @(posedge clk) begin
		case (flip_flop)
			2'b00: if (a == 0 && b == 0) flip_flop <= 2'b00;
			       else if (a == 0 && b == 1) flip_flop <= 2'b10;
			       else if (a == 1 && b == 0) flip_flop <= 2'b01;
			       else flip_flop <= 2'b11;
			2'b01: flip_flop <= 2'b10;
			2'b10: flip_flop <= 2'b01;
			2'b11: flip_flop <= 2'b00;
			default: flip_flop <= 2'b00;
		endcase
	end

	assign q = flip_flop[0];
	assign state = flip_flop[1];

endmodule
