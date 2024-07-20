module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;
	reg out_reg;

	always @(posedge clk or posedge areset)begin

		if(areset)
			state <= 2'b0;
		else
			case(state)
				2'b00: state <= (in == 1'b1) ? 2'b00 : 2'b01;
				2'b01: state <= (in == 1'b1) ? 2'b01 : 2'b00;
				default: state <= 2'b00;
			endcase

		end

	always @(state)begin

		out_reg <= (state == 2'b01) ? 1'b1 : 1'b0;

	end

	assign out = out_reg;

endmodule
