module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	reg [1:0] current_state;
	reg [1:0] next_state;
	
	// Define outputs
	reg out_reg;
	
	always @(posedge clk) begin
		// Update next_state based on current_state and inputs
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
			default: next_state = A;
		endcase
		
		// Update current_state and output based on next_state
		if (reset) begin
			current_state <= A;
			out_reg <= 0;
		end else begin
			current_state <= next_state;
			if (current_state == D) begin
				out_reg <= 1;
			end else begin
				out_reg <= 0;
			end
		end
	end
	
	assign out = out_reg;
	
endmodule
