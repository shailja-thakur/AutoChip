module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	reg [1:0] state;
	reg z_next;

	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b00; // reset to state A
		else
			state <= state;
	end
	
	always @(state, x)
	begin
		case (state)
			2'b00:
				begin
					if (x)
						state <= 2'b01; // transition to state B if x is 1
					else
						state <= 2'b00; // stay in state A if x is 0
				end
			2'b01:
				begin
					if (x)
						state <= 2'b10; // stay in state B if x is 1
					else
						state <= 2'b01; // stay in state B if x is 0
				end
			default:
				state <= state; // should not happen
		endcase
	end
	
	always @(state)
	begin
		case (state)
			2'b00: z_next = 1'b0; // z = 0 in state A
			2'b01: z_next = 1'b1; // z = 1 in state B
			default: z_next = 1'b0; // default value
		endcase
	end
	
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			z <= 1'b0; // reset to 0
		else
			z <= z_next;
	end

endmodule
