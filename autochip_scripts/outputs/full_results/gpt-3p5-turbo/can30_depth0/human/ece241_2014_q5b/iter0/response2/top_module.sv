module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// Define the state enumeration
	typedef enum logic [1:0] {
		A,
		B
	} state_t;
	
	// Define the signals for the current state and next state
	logic [1:0] current_state;
	logic [1:0] next_state;
	
	// Define the outputs
	assign z = (current_state == B) ? 1'b0 : 1'b1;
	
	// Define the state transition and output logic
	always_ff @(posedge clk, posedge areset) begin
		if (areset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	always_comb begin
		case (current_state)
			A: begin
				if (x) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (x) begin
					next_state = B;
				end else begin
					next_state = B;
				end
			end
			default: begin
				next_state = A;
			end
		endcase
	end

endmodule
