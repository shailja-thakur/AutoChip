module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
	
	// Output declarations
	reg out1;
	reg out2;
	
	// State transition logic
	always @(state or in) begin
		case (state)
			10'b0000000001: begin // S0
				if (in == 1)
					next_state = 10'b0000000010; // S1
				else
					next_state = 10'b0000000001; // S0
			end
			
			10'b0000000010: begin // S1
				if (in == 1)
					next_state = 10'b0000000100; // S2
				else
					next_state = 10'b0000000001; // S0
			end
			
			10'b0000000100: begin // S2
				if (in == 1)
					next_state = 10'b0000001000; // S3
				else
					next_state = 10'b0000000001; // S0
			end
			
			10'b0000001000: begin // S3
				if (in == 1)
					next_state = 10'b0000010000; // S4
				else
					next_state = 10'b0000000001; // S0
			end
			
			10'b0000010000: begin // S4
				if (in == 1)
					next_state = 10'b0000100000; // S5
				else
					next_state = 10'b0000000001; // S0
			end
			
			10'b0000100000: begin // S5
				if (in == 1)
					next_state = 10'b0000001000; // S8
				else
					next_state = 10'b0000000010; // S1
			end
			
			10'b0000001000: begin // S6
				if (in == 1)
					next_state = 10'b0000010000; // S9
				else
					next_state = 10'b0000000110; // S7
			end
			
			10'b0000000110: begin // S7
				if (in == 1)
					next_state = 10'b0000000110; // S7
				else
					next_state = 10'b0000000001; // S0
			end
			
			10'b0000000001: begin // S8
				if (in == 1)
					next_state = 10'b0000000010; // S1
				else
					next_state = 10'b0000000001; // S0
			end
			
			10'b0000000010: begin // S9
				if (in == 1)
					next_state = 10'b0000000100; // S2
				else
					next_state = 10'b0000000001; // S0
			end
			
			default: next_state = 10'b0000000001; // Default case for invalid state
		endcase
	end
	
	// Output logic
	always @(state) begin
		case (state)
			10'b0000010000: begin // S4
				out1 = 1;
				out2 = 0;
			end
			
			10'b0000000110: begin // S7
				out1 = 0;
				out2 = 1;
			end
			
			default: begin
				out1 = 0;
				out2 = 0;
			end
		endcase
	end
	
endmodule
