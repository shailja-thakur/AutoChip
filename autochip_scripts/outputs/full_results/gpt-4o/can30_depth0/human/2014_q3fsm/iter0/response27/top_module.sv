module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// Define state encoding
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter CHECK = 2'b10;
	parameter OUTPUT = 2'b11;
	
	reg [1:0] state, next_state;
	reg [1:0] w_count; // Counter for input w

	// State transition logic
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
			w_count <= 2'b00;
			z <= 0;
		end else begin
			state <= next_state;
			case (next_state)
				CHECK: w_count <= w_count + w;
				OUTPUT: begin
					z <= (w_count == 2);
					w_count <= 0;
				end
				default: w_count <= 0;
			endcase
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: begin
				if (s)
					next_state = B;
				else
					next_state = A;
			end

			B: next_state = CHECK;

			CHECK: begin
				if (state == CHECK && w_count < 2) 
					next_state = OUTPUT;
				else
					next_state = CHECK;
			end

			OUTPUT: next_state = CHECK;

			default: next_state = A;
		endcase
	end

endmodule
