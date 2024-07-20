module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	reg [1:0] state;
	reg [1:0] next_state;

	always @(posedge clk, posedge areset)
	begin
		if (areset)
			state <= 2'b10; // B state
		else
			state <= next_state;
	end

	always @*
	begin
		case (state)
			2'b00: // A state
				begin
					if (in)
						next_state = 2'b00; // A state
					else
						next_state = 2'b01; // B state
				end
			2'b01: // B state
				begin
					if (in)
						next_state = 2'b01; // B state
					else
						next_state = 2'b00; // A state
				end
			default: next_state = 2'b01; // B state
		endcase
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
