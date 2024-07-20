module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	reg [9:0] next_state;

	always_comb begin
		case (state)
			10'b0000000001: next_state = 10'b0000000001;
			10'b0000000010: next_state = 10'b0000000100;
			10'b0000000100: next_state = 10'b0000000001;
			10'b0000001000: next_state = 10'b0000001000;
			10'b0000010000: next_state = 10'b0000000001;
			10'b0000100000: next_state = 10'b0000000010;
			10'b0001000000: next_state = 10'b0000000001;
			10'b0010000000: next_state = 10'b0000000010;
			10'b0000010001: next_state = 10'b0000000010;
			10'b0001000010: next_state = 10'b0000000001;
			10'b0000100100: next_state = 10'b0000001000;
			10'b0001001000: next_state = 10'b0000001001;
			10'b0010010000: next_state = 10'b0000000001;
			10'b0010100000: next_state = 10'b0000000100;
			10'b0100000000: next_state = 10'b0000000001;
			10'b0000000001: next_state = 10'b0000000001;
			default: next_state = 10'b0000000000; // trap state
		endcase
	end

	assign out1 = (state == 10'b0000000111) ? 1'b0 : 1'b0;
	assign out2 = (state == 10'b0000011100) ? 1'b1 : 1'b0;

endmodule
