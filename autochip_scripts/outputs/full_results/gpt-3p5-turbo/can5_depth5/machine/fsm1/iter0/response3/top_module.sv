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
		else if (state == 2'b00 && in)
			state <= 2'b00;
		else if (state == 2'b10 && in)
			state <= 2'b10;
		else if (state == 2'b00 && !in)
			state <= 2'b10;
		else if (state == 2'b10 && !in)
			state <= 2'b00;
	end
	
	assign out = (state == 2'b10) ? 1'b1 : 1'b0;

endmodule
