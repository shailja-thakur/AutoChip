module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	// define the states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_t;
	
	// define the current state signal and initialize it to A
	reg state_t current_state = A;
	
	// define the next state signal
	reg state_t next_state;
	
	// define the output signal and initialize it to 0
	reg out = 0;
	
	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	always_comb begin
		case (current_state)
			A: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
			C: begin
				if (in) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end
			D: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
		endcase
	end
	
	assign out = (current_state == D) ? 1'b1 : 1'b0;
	
endmodule
