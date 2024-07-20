module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

wire y1;
assign y1 = y[1];

always @(*) begin
    Y2 = y1 & ~w;
end

always @(*) begin
    Y4 = y[6] & y[5] & y[3] & y[2] & w;
end

endmodule
