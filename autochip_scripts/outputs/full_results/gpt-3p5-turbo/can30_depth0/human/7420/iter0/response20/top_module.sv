module top_module(
input [7:0] p1,
input [7:0] p2,
output p1y,
output p2y
);

wire [7:0] n1;
wire [7:0] n2;
wire [3:0] n3;

assign n1 = ~p1;
assign n2 = ~p2;
assign n3 = n1 & n2;

assign p1y = n3[1] & n3[3] & n3[5] & n3[7];
assign p2y = n3[0] & n3[2] & n3[4] & n3[6];

endmodule
