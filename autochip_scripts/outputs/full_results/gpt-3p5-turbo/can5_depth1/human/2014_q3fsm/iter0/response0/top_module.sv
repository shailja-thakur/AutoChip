module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	// Define states
	typedef enum logic [1:0] {
		A,
		B
	} state_type;
	
	// Define state register
	reg state_type current_state, next_state;
	
	// Define count register to keep track of number of w=1 signals in B state
	reg [1:0] count;
	
	// Default state initialization
	always @(posedge clk) begin
		if (reset) begin
			current_state <= A;
			count <= 0;
		end else begin
			current_state <= next_state;
		end
	end
	
	always_comb begin
		next_state = current_state;
		
		case (current_state)
			A: begin
				if (s == 1) begin
					next_state = B;
				end
			end
			
			B: begin
				if (s == 0) begin
					next_state = A;
				end
				
				if (w == 1) begin
					count <= count + 1;
				end
				
				if (count >= 2) begin
					next_state = A;
					z <= 1;
				end else begin
					z <= 0;
				end
			end
		endcase
	end
endmodule
