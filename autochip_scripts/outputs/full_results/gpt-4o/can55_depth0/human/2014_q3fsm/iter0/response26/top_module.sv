module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// Define state encoding
	localparam A = 2'b00, B = 2'b01, CHECK = 2'b10;
	reg [1:0] state, next_state;
	reg [1:0] w_count;  // Counter to keep track of 'w' being high

	always @(posedge clk) begin
		if (reset) begin
			state <= A;
			w_count <= 2'b0;
			z <= 1'b0;
		end else begin
			state <= next_state;

			if (state == CHECK) begin
				if (w) w_count <= w_count + 1;
				if (w_count == 2'b11) begin  // Counter was reset every 3 cycles with next_state logic
					z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
					w_count <= 2'b0;
				end
			end else begin
				w_count <= 2'b0;
				z <= 1'b0;
			end
		end
	end

	always @(*) begin
		next_state = state; // default state
		case (state)
			A: if (s) next_state = B;
			B: next_state = CHECK;
			CHECK: if (w_count == 2'b11) next_state = B;  // every 3 cycles move back to B
		endcase
	end
endmodule
