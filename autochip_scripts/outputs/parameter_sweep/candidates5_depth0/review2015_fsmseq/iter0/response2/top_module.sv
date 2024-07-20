module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
	
	// Create states of the FSM
	typedef enum logic [1:0] {
		IDLE,
		START,
		S0,
		S1,
		S2,
		S3,
		DONE
	} state_t;
	
	reg state_t current_state, next_state;
	
	always_ff @(posedge clk) begin
		if (reset) begin
			current_state <= IDLE;
		end else begin
			current_state <= next_state;
		end
	end
	
	always_comb begin
		next_state = current_state;
		
		case (current_state)
			IDLE: begin
				if (data) begin
					next_state = START;
				end else begin
					next_state = IDLE;
				end
			end
			
			START: begin
				if (data) begin
					next_state = S0;
				end else begin
					next_state = IDLE;
				end
			end
			
			S0: begin
				if (data) begin
					next_state = S0;
				end else begin
					next_state = S1;
				end
			end
			
			S1: begin
				if (data) begin
					next_state = S2;
				end else begin
					next_state = START;
				end
			end
			
			S2: begin
				if (data) begin
					next_state = S3;
				end else begin
					next_state = S1;
				end
			end
			
			S3: begin
				if (data) begin
					next_state = DONE;
				end else begin
					next_state = S0;
				end
			end
			
			DONE: begin
				next_state = IDLE;
			end
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset) begin
			start_shifting <= 0;
		end else begin
			if (current_state == DONE) begin
				start_shifting <= 1;
			end else begin
				start_shifting <= 0;
			end
		end
	end

endmodule
