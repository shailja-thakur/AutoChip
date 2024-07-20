module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg [31:0] x_reg;
reg [31:0] z_reg;
reg start_conversion;

always@(posedge clk or negedge areset) begin
	if(areset == 0) begin
		x_reg <= 0;
		z_reg <= 0;
		start_conversion <= 0;
	end else begin
		x_reg <= {x_reg[30:0], x};
		if (start_conversion == 1) begin
			z_reg <= ~x_reg + 1;
		end
		else if (x != 0) begin
			start_conversion <= 1;
		end
	end
end

always @(posedge clk) begin
	if (areset == 1) begin
		start_conversion <= 0;
	end
end

assign z = z_reg[0];

endmodule
