module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State encoding
	localparam A = 1'b0, B = 1'b1;

	reg state, next_state;
	reg [1:0] w_count;
	reg [1:0] cycle_count;

	// State transition logic
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
			w_count <= 0;
			cycle_count <= 0;
			z <= 0;
		end else begin
			state <= next_state;
			if (cycle_count == 2'd3) begin
				if (w_count == 2'd2)
					z <= 1;
				else
					z <= 0;
				w_count <= 0;
				cycle_count <= 0;
			end else if (state == B) begin
				cycle_count <= cycle_count + 1;
				if (w == 1)
					w_count <= w_count + 1;
			end
		end
	end

	// Next state logic
	always @ (*) begin
		case (state)
			A: begin
				if (s)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (cycle_count == 2'd3)
					next_state = A;
				else
					next_state = B;
			end
			default: next_state = A;
		endcase
	end

endmodule
