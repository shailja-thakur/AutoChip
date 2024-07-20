module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 2'b00; // initial state A
		else
		begin
			case (state)
				0: // state A
				begin
					if (in)
						state <= 2'b01; // state B
					else
						state <= 2'b00; // remain in state A
				end
				1: // state B
				begin
					if (in)
						state <= 2'b01; // remain in state B
					else
						state <= 2'b10; // state C
				end
				2: // state C
				begin
					if (in)
						state <= 2'b11; // state D
					else
						state <= 2'b00; // state A
				end
				3: // state D
				begin
					if (in)
						state <= 2'b01; // state B
					else
						state <= 2'b10; // state C
				end
			endcase
		end
	end

	assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
