module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define the state enum
	typedef enum logic [2:0] {S0, S1, S2, S3, S4} state_t;

	// Define the state register
	reg state_t current_state;
	reg start_shift;

	always @(posedge clk) begin
		if (reset == 1'b1) begin
			current_state <= S0;
			start_shift <= 1'b0;
		end else begin
			case (current_state)
				S0: begin
					if (data == 1'b1)
						current_state <= S1;
					else
						current_state <= S0;
				end
				S1: begin
					if (data == 1'b1)
						current_state <= S2;
					else
						current_state <= S0;
				end
				S2: begin
					if (data == 1'b0)
						current_state <= S3;
					else
						current_state <= S0;
				end
				S3: begin
					if (data == 1'b1) begin
						current_state <= S4;
						start_shift <= 1'b1;
					end else
						current_state <= S0;
				end
				S4: begin
					current_state <= S0;
				end
			endcase
		end
	end

	assign start_shifting = start_shift;

endmodule
