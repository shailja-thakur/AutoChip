module top_module (
	input [5:0] y,
	input w,
	output reg Y1,
	output reg Y3
);

reg [1:0] Y_reg;

always @(posedge w) begin
	Y_reg <= y[3:2];
end

always @* begin
	Y1 = (Y_reg == 2'b10);
	Y3 = (Y_reg == 2'b01);
end

endmodule
