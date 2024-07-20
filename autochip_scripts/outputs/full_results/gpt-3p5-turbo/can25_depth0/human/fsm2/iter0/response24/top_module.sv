module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);
	
	// Define the state enum
	typedef enum logic [1:0] {
		OFF,
		ON
	} state_t;

	// Define the state and next_state variables
	reg state_t state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or j or k) begin
		case (state)
			OFF: begin
				if (j) begin
					next_state <= ON;
				end else begin
					next_state <= OFF;
				end
				
				out <= 0;
			end
			
			ON: begin
				if (k) begin
					next_state <= OFF;
				end else begin
					next_state <= ON;
				end
				
				out <= 1;
			end
		endcase
	end
	
endmodule
