module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// State definition
	typedef enum logic [1:0] {
		IDLE,
		CONVERT
	} state_t;
	
	// State and output signals
	reg state_t current_state, next_state;
	reg signed [31:0] count;
	reg signed [31:0] sum;
	
	// Outputs
	assign z = sum;
	
	// Sequential logic
	always @(posedge clk or negedge areset) begin
		if (!areset) begin
			current_state <= IDLE;
			count <= 0;
			sum <= 0;
		end
		else begin
			current_state <= next_state;
			
			case (current_state)
				IDLE: begin
					if (!areset && x != 0) begin
						next_state <= CONVERT;
						count <= 0;
						sum <= x;
					end
					else begin
						next_state <= IDLE;
						count <= 0;
						sum <= 0;
					end
				end
				
				CONVERT: begin
					if (count < $bits(x) - 1) begin
						next_state <= CONVERT;
						count <= count + 1;
						sum <= sum + (x << count);
					end
					else begin
						next_state <= IDLE;
						count <= 0;
						sum <= sum + (x << count);
					end
				end
			endcase
		end
	end
endmodule
