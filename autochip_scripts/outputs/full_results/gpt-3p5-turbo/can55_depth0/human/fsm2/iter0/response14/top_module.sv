module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define state enum
	typedef enum logic [1:0] {OFF, ON} state_t;
	
	// Define state and next_state signals
	reg state_t state, next_state;
	
	// Define output signal
	wire out;
	
	// Define state transition logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end
	
	// Define next_state logic
	always @(state, j, k) begin
		case (state)
			OFF: begin
				if (j) begin
					next_state = ON;
				end else begin
					next_state = OFF;
				end
			end
			ON: begin
				if (k) begin
					next_state = OFF;
				end else begin
					next_state = ON;
				end
			end
		endcase
	end
	
	// Define output assignment logic
	assign out = (state == ON) ? 1'b1 : 1'b0;

endmodule
