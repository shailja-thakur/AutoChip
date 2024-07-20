module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define states
	typedef enum logic [1:0] {
		IDLE,
		S0,
		S1,
		S2,
		S3
	} state_t;
	
	// State register
	reg state_t current_state;
	
	// Output register
	reg start_shifting_reg;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			start_shifting_reg <= 0;
		end
		else begin
			case (current_state)
				IDLE: begin
					if (data) begin
						current_state <= S0;
						start_shifting_reg <= 0;
					end
				end
				
				S0: begin
					if (data) begin
						current_state <= S1;
						start_shifting_reg <= 0;
					end
					else begin
						current_state <= IDLE;
						start_shifting_reg <= 0;
					end
				end
				
				S1: begin
					if (!data) begin
						current_state <= IDLE;
						start_shifting_reg <= 0;
					end
					else begin
						current_state <= S2;
						start_shifting_reg <= 0;
					end
				end
				
				S2: begin
					if (data) begin
						current_state <= S3;
						start_shifting_reg <= 0;
					end
					else begin
						current_state <= IDLE;
						start_shifting_reg <= 0;
					end
				end
				
				S3: begin
					current_state <= IDLE;
					start_shifting_reg <= data;
				end
			endcase
		end
	end
	
	assign start_shifting = start_shifting_reg;
	
endmodule
