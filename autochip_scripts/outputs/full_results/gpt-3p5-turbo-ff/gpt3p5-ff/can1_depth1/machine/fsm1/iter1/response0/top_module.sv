module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg [1:0] state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b01;  // reset state to B
		else if (state == 2'b01) begin  // state A
			if (in)
				state <= 2'b01;  // next state A
			else
				state <= 2'b10;  // next state B
		end else begin  // state B
			if (in)
				state <= 2'b10;  // next state B
			else
				state <= 2'b01;  // next state A
		end
	end

	assign out = (state == 2'b10);

endmodule
