module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg [31:0] x_reg;
reg [31:0] z_reg;
reg reset_sync;

always@(posedge clk or negedge areset) begin
	if(areset == 0) begin
		x_reg <= 0;
		z_reg <= 0;
		reset_sync <= 0;
	end else begin
		x_reg <= {x_reg[30:0], x};
		if(reset_sync == 1) begin
			z_reg <= 0;
		end else begin
			z_reg <= ~x_reg + 1;
		end
		reset_sync <= areset; // synchronously update the reset signal
	end
end

assign z = z_reg[0];

endmodule
