module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// Define states
	typedef enum logic [1:0] {
		A, B
	} state_t;
	
	// Declare state register
	reg state_t current_state, next_state;
	
	// Declare output register
	reg output reg z_reg;
	
	// State transition and output logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= A;
			z_reg <= 0;
		end else begin
			current_state <= next_state;
			z_reg <= (current_state == B);
		end
	end
	
	// Next state logic
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
		endcase
	end
	
	// Assign output
	assign z = z_reg;
	
endmodule
