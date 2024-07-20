module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	reg [1:0] state, next_state;
	reg [1:0] w_count, next_w_count;
	
	// State encoding
	parameter A = 2'b00;
	parameter B1 = 2'b01;
	parameter B2 = 2'b10;
	parameter B3 = 2'b11;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
			w_count <= 2'b00;
			z <= 1'b0;
		end
		else begin
			state <= next_state;
			w_count <= next_w_count;
		end
	end

	// Next state logic
	always @(*) begin
		next_state = state;
		next_w_count = w_count;
		z = 1'b0;
		
		case (state)
			A: begin
				if (s) 
					next_state = B1;
			end
			
			B1: begin
				if (w)
					next_w_count = w_count + 1;
				next_state = B2;
			end

			B2: begin
				if (w)
					next_w_count = w_count + 1;
				next_state = B3;
			end

			B3: begin
				if (w)
					next_w_count = w_count + 1;
					
				if (next_w_count == 2'b10)
					z = 1'b1;
			
				next_w_count = 2'b00; // reset the count
				next_state = A; // Reset state to A to check `s` input again
			end
		endcase
	end

endmodule
