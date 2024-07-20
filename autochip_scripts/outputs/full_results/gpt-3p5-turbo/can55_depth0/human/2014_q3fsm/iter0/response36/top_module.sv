module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	reg [1:0] state, next_state;
	
	// Define state values
	parameter A = 2'b00; // reset state
	parameter B = 2'b01; // state B
	
	// Initial state
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Next state logic
	always @(state or w) begin
		case (state)
			A: begin
				if (s)
					next_state <= B;
				else
					next_state <= A;
			end
			B: begin
				if (w)
					next_state <= B;
				else
					next_state <= A;
			end
		endcase
	end
	
	// Output logic
	always @(state or w) begin
		if (state == B) begin
			if (w == 1'b1) begin
				z <= 1'b1;
			end else begin
				z <= 1'b0;
			end
		end else begin
			z <= 1'b0;
		end
	end
	
endmodule
