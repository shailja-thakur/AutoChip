module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;
	reg out_reg;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00;
		else begin
			case (state)
				2'b00: state <= (in ? 2'b01 : 2'b10);
				2'b01: state <= (in ? 2'b11 : 2'b01);
				2'b10: state <= (in ? 2'b00 : 2'b11);
				2'b11: state <= (in ? 2'b10 : 2'b01);
			endcase
		end
	end

	always @(state) begin
		case (state)
			2'b00: out_reg = 1'b0;
			2'b01: out_reg = 1'b0;
			2'b10: out_reg = 1'b0;
			2'b11: out_reg = 1'b1;
		endcase
	end

	assign out = out_reg;
endmodule
