module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);
	
	reg [2:0] state, next_state;
	reg disc_out, flag_out, err_out;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000; // Initial state
		end else begin
			state <= next_state;
		end
	end
	
	always @* begin
		next_state = state;
		disc_out = 0;
		flag_out = 0;
		err_out = 0;
		
		case (state)
			3'b000: // Initial state
				if (in) begin
					next_state = 3'b001; // Next state: First bit of frame
				end else begin
					next_state = 3'b000; // Stay in the initial state
				end
			3'b001: // First bit of frame
				if (in) begin
					next_state = 3'b010; // Next state: Second bit of frame
				end else begin
					next_state = 3'b000; // Return to initial state
				end
			3'b010: // Second bit of frame
				if (in) begin
					next_state = 3'b011; // Next state: Third bit of frame
				end else begin
					next_state = 3'b000; // Return to initial state
				end
			3'b011: // Third bit of frame
				if (in) begin
					next_state = 3'b100; // Next state: Fourth bit of frame
				end else begin
					next_state = 3'b000; // Return to initial state
				end
			3'b100: // Fourth bit of frame
				if (in) begin
					next_state = 3'b101; // Next state: Fifth bit of frame
				end else begin
					next_state = 3'b000; // Return to initial state
				end
			3'b101: // Fifth bit of frame
				if (in) begin
					next_state = 3'b110; // Next state: Sixth bit of frame
				end else begin
					next_state = 3'b000; // Return to initial state
				end
			3'b110: // Sixth bit of frame
				if (in) begin
					next_state = 3'b000; // Return to initial state
				end else begin
					next_state = 3'b111; // Next state: Potential flag
				end
			3'b111: // Potential flag
				if (in) begin
					next_state = 3'b111; // Stay in potential flag state
				end else begin
					next_state = 3'b000; // Return to initial state
				end
		endcase
		
		if (state == 3'b110) begin
			disc_out = 1; // Set discard output
		end else if (state == 3'b111) begin
			if (in) begin
				flag_out = 1; // Set flag output
			end else begin
				err_out = 1; // Set error output
			end
		end
	end
	
	assign disc = disc_out;
	assign flag = flag_out;
	assign err = err_out;
	
endmodule
