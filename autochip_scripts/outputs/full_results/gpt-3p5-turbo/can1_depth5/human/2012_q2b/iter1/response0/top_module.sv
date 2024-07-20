module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg [1:0] Y_reg;

always @(posedge w) begin
	Y_reg <= y[3:2];
end

assign Y1 = (Y_reg == 2'b10);
assign Y3 = (Y_reg == 2'b01);

endmodule
