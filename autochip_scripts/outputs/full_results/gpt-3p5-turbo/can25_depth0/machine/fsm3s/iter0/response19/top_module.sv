module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else if (state == 2'b00) begin
			if (in)
				state <= 2'b01;
		end else if (state == 2'b01) begin
			if (in)
				state <= 2'b01;
			else
				state <= 2'b10;
		end else if (state == 2'b10) begin
			if (in)
				state <= 2'b11;
			else
				state <= 2'b00;
		end else if (state == 2'b11) begin
			if (in)
				state <= 2'b01;
			else
				state <= 2'b10;
		end
	end

	assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
