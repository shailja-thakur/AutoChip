module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

	reg [2:0] state;
	reg [2:0] next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000; // initialize state to A
		end else begin
			state <= next_state;
		end
	end

	always @(state or x) begin
		case (state)
			3'b000: // state A
				begin
					if (x)
						next_state = 3'b001; // transition to state B
					else
						next_state = 3'b000; // stay in state A
				end
			3'b001: // state B
				begin
					if (x)
						next_state = 3'b010; // transition to state E
					else
						next_state = 3'b001; // stay in state B
				end
			3'b010: // state C
				begin
					if (x)
						next_state = 3'b001; // transition to state B
					else
						next_state = 3'b010; // stay in state C
				end
			3'b011: // state D
				begin
					if (x)
						next_state = 3'b010; // transition to state C
					else
						next_state = 3'b001; // transition to state B
				end
			3'b100: // state E
				begin
					if (x)
						next_state = 3'b100; // stay in state E
					else
						next_state = 3'b011; // transition to state D
				end
			default: next_state = 3'b000; // state A as default
		endcase
	end

	always @(state) begin
		if (state == 3'b011 || state == 3'b100) // state D or state E
			z = 1'b1; // set output z to high
		else
			z = 1'b0; // set output z to low
	end

endmodule
