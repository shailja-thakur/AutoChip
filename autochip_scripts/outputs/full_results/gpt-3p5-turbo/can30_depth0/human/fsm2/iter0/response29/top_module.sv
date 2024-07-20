module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b0;
		else if (state == 2'b00 && j)
			state <= 2'b01;
		else if (state == 2'b01 && k)
			state <= 2'b00;
		else if (state == 2'b01)
			state <= 2'b01;
		else if (state == 2'b00)
			state <= 2'b00;
	end

	always @(state) begin
		case (state)
			2'b00: out <= 1'b0;
			2'b01: out <= 1'b1;
		endcase
	end
endmodule
