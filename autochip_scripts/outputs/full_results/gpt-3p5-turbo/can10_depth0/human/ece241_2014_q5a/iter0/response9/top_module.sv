module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	/* States */
	typedef enum logic [2:0] {
		S_START,
		S_CONVERT,
		S_DONE
	} state_t;
	
	/* Signals */
	reg state_t state, next_state;
	reg signed [31:0] result;
	
	/* State register */
	always_ff @(posedge clk or negedge areset) begin
		if (~areset) begin
			state <= S_START;
			result <= 0;
		end else begin
			state <= next_state;
			result <= (state == S_CONVERT) ? ~(result + x) : result;
		end
	end
	
	/* Next-state logic */
	always_comb begin
		case (state)
			S_START: begin
				if (~areset)
					next_state = S_START;
				else
					next_state = S_CONVERT;
			end
			
			S_CONVERT: begin
				if (x === 1'b1)
					next_state = S_DONE;
				else
					next_state = S_CONVERT;
			end
			
			S_DONE: begin
				if (~areset)
					next_state = S_START;
				else
					next_state = S_DONE;
			end
		endcase
	end
	
	/* Output logic */
	assign z = result;
			
endmodule
