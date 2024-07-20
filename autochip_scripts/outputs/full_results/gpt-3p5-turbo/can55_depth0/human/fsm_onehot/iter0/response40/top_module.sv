module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Combinational logic for state transition and output logic
	always @*
	begin
		case(state)
			10'b0000000001: begin
				next_state = 10'b1000000000;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000010: begin
				next_state = 10'b0000000100;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000100: begin
				next_state = 10'b1000000000;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000001000: begin
				next_state = 10'b0000001000;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000010000: begin
				next_state = 10'b1000000000;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000100000: begin
				next_state = 10'b0100000000;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0001000000: begin
				next_state = 10'b1000000000;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0010000000: begin
				next_state = 10'b0100000000;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0100000000: begin
				next_state = 10'b0000000001;
				out1 = 1'b0;
				out2 = 1'b1;
			end
			10'b1000000000: begin
				next_state = 10'b0000000010;
				out1 = 1'b1;
				out2 = 1'b0;
			end
			default: begin
				next_state = 10'b0000000000;
				out1 = 1'b0;
				out2 = 1'b0;
			end
		endcase
	end

endmodule
