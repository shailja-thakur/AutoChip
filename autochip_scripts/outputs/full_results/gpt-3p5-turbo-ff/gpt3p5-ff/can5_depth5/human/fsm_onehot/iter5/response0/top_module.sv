module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2);

	always @* begin
		case(state)
			10'b0000000001: begin
				if(in)
					next_state = 10'b0000000010; // S0, input 1
				else
					next_state = 10'b0000000001; // S0, input 0
			end
			10'b0000000010: begin
				if(in)
					next_state = 10'b0000000011; // S1, input 1
				else
					next_state = 10'b0000000001; // S1, input 0
			end
			10'b0000000011: begin
				if(in)
					next_state = 10'b0000000100; // S2, input 1
				else
					next_state = 10'b0000000001; // S2, input 0
			end
			10'b0000000100: begin
				if(in)
					next_state = 10'b0000000101; // S3, input 1
				else
					next_state = 10'b0000000001; // S3, input 0
			end
			10'b0000000101: begin
				if(in)
					next_state = 10'b0000000110; // S4, input 1
				else
					next_state = 10'b0000000001; // S4, input 0
			end
			10'b0000000110: begin
				if(in)
					next_state = 10'b0000001000; // S5, input 1
				else
					next_state = 10'b0000000111; // S5, input 0
			end
			10'b0000000111: begin
				if(in)
					next_state = 10'b0000000101; // S6, input 1
				else
					next_state = 10'b0000001001; // S6, input 0
			end
			10'b0000001000: begin
				if(in)
					next_state = 10'b0000000001; // S7, input 1
				else
					next_state = 10'b0000000001; // S7, input 0
			end
			10'b0000001001: begin
				if(in)
					next_state = 10'b0000000010; // S8, input 1
				else
					next_state = 10'b0000000001; // S8, input 0
			end
			10'b0000001010: begin
				if(in)
					next_state = 10'b0000000010; // S9, input 1
				else
					next_state = 10'b0000000001; // S9, input 0
			end
			default: next_state = 10'b0000000000; // Default case to handle undefined state
		endcase
	end

	always @* begin
		case(state)
			10'b0000000110: out1 = 1'b1;
			default: out1 = 1'b0;
		endcase
		
		case(state)
			10'b0000000111: out2 = 1'b1;
			default: out2 = 1'b0;
		endcase
	end

endmodule
