module top_module (
	input wire in,
	input wire [9:0] state,
	output wire [9:0] next_state,
	output wire out1,
	output wire out2
);

	// Define the logic equations for the states transitions and outputs
	always @* begin
		case(state)
			10'b0000000001: begin
				next_state = in ? 10'b0000000010 : 10'b0000000001;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000010: begin
				next_state = in ? 10'b0000000011 : 10'b0000000001;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000011: begin
				next_state = in ? 10'b0000000100 : 10'b0000000001;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000100: begin
				next_state = in ? 10'b0000000101 : 10'b0000000001;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000101: begin
				next_state = in ? 10'b0000001000 : 10'b0000000110;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000110: begin
				next_state = in ? 10'b0000001001 : 10'b0000000001;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000111: begin
				next_state = in ? 10'b0000000001 : 10'b0000000111;
				out1 = 1'b0;
				out2 = 1'b1;
			end
			10'b0000001000: begin
				next_state = in ? 10'b0000000001 : 10'b0000001000;
				out1 = 1'b1;
				out2 = 1'b0;
			end
			10'b0000001001: begin
				next_state = in ? 10'b0000000001 : 10'b0000000010;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000001010: begin
				next_state = in ? 10'b0000000001 : 10'b0000000010;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			default: begin
				next_state = 10'bxxxxxxxxxx;
				out1 = 1'bx;
				out2 = 1'bx;
			end
		endcase
	end

endmodule
