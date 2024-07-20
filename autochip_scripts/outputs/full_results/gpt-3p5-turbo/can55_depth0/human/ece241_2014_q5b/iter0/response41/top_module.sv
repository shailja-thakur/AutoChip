module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	// Define states
	enum logic [1:0] {A, B} current_state, next_state;
	
	// Define outputs
	logic z_next;
	
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= A;
		end
		else begin
			current_state <= next_state;
		end
	end
	
	always_comb begin
		case (current_state)
			A: begin
				if (x == 0) begin
					z_next = 0;
					next_state = A;
				end
				else begin
					z_next = 1;
					next_state = B;
				end
			end
			
			B: begin
				if (x == 0) begin
					z_next = 1;
					next_state = B;
				end
				else begin
					z_next = 0;
					next_state = B;
				end
			end
		endcase
	end
	
	assign z = z_next;
	
endmodule
