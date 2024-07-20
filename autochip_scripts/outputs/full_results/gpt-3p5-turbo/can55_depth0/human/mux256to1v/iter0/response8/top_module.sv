module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [255:0] in_mux;
wire [7:0] sel_mux;

assign in_mux = {in[1023:768], in[767:512], in[511:256], in[255:0]};
assign sel_mux = sel << 5;

assign out = in_mux[sel_mux +: 4];

endmodule
