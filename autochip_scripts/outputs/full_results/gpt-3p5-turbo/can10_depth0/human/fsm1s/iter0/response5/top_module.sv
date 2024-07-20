module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg state;
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 1'b0;
		else
		begin
			case (state)
				0: begin
					if (in)
						state <= 1'b0;
					else
						state <= 1'b1;
					end
				1: begin
					if (in)
						state <= 1'b1;
					else
						state <= 1'b0;
					end
				default: state <= 1'b0;
			endcase
		end
	end

	assign out = state;

endmodule
