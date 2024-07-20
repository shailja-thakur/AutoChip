module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg [1:0] state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b0;  // initialize state as B
		else if (state == 2'b00) begin  // state A
			if (in)
				state <= 2'b00;  // next state A
			else
				state <= 2'b01;  // next state B
		end else begin  // state B
			if (in)
				state <= 2'b11;  // next state B
			else
				state <= 2'b00;  // next state A
		end
	end

	assign out = (state == 2'b01);

endmodule
