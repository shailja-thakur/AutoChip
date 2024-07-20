module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [31:0] x_reg;
reg [31:0] z_reg;
reg reset;

always@(posedge clk) begin
	if(areset) begin
		x_reg <= 0;
		z_reg <= 0;
		reset <= 1;
	end else if(reset) begin
		x_reg <= {x_reg[30:0], x};
		z_reg <= ~x_reg + 1;
		reset <= 0;
	end else begin
		x_reg <= {x_reg[30:0], x};
		z_reg <= ~x_reg + 1;
	end
end

assign z = z_reg[0];

endmodule
