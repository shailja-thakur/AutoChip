module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	reg [1:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b01;
		else begin
			if (state == 2'b00) begin
				if (in)
					state <= 2'b00;
				else
					state <= 2'b01;
			end else begin
				if (in)
					state <= 2'b01;
				else
					state <= 2'b00;
			end
		end
	end
	assign out = (state == 2'b01) ? 1'b1 : 1'b0;
endmodule
