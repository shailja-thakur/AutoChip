module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	reg [1:0] state;
	reg [1:0] next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;  // Reset state A
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or w) begin
		case(state)
			2'b00: begin  // State A
				if (s == 1'b1) begin
					next_state = 2'b01;  // Move to state B
				end else begin
					next_state = 2'b00;  // Stay in state A
				end
			end
			
			2'b01: begin  // State B
				if (w == 1'b1) begin
					next_state = 2'b11;  // Move to state C
				end else begin
					next_state = 2'b10;  // Stay in state B
				end
			end
			
			2'b10: begin  // State C
				if (w == 1'b1) begin
					next_state = 2'b11;  // Stay in state C
				end else begin
					next_state = 2'b00;  // Move back to state A
				end
			end
			
			2'b11: begin  // State D
				if (w == 1'b1) begin
					next_state = 2'b11;  // Stay in state D
				end else begin
					next_state = 2'b00;  // Move back to state A
				end
			end
		endcase
	end
	
	always @(posedge clk) begin
		if (state == 2'b11) begin
			z <= 1'b1;  // Set output z to 1 if in state D
		end else begin
			z <= 1'b0;  // Set output z to 0 for all other states
		end
	end
endmodule
