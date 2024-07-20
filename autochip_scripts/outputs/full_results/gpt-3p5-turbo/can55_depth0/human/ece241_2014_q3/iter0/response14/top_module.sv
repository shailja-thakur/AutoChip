module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [3:0] w;
wire a;
wire b;
wire ab;
wire cd;

assign w[0] = ~c & ~d;
assign w[1] = c & ~d;
assign w[2] = c & d;
assign w[3] = c & ~d;

assign a = ab[1];
assign b = ab[0];
assign cd = c & d;

assign mux_in[0] = w[0];
assign mux_in[1] = w[1];
assign mux_in[2] = w[2];
assign mux_in[3] = w[3];

mux_4to1 mux (
	.a(ab),
	.cd(cd),
	.out(mux_in)
);

endmodule
module mux_4to1 (
    input [1:0] a,
    input cd,
    output [3:0] out
);
    wire [3:0] w;

    mux_2to1 mux1 (
        .a(a[0]),
        .b(a[1]),
        .cd(cd),
        .out(w[0])
    );

    mux_2to1 mux2 (
        .a(w[0]),
        .b(w[1]),
        .cd(cd),
        .out(w[1])
    );

    mux_2to1 mux3 (
        .a(w[2]),
        .b(w[3]),
        .cd(cd),
        .out(w[2])
    );

    assign out[0] = w[0];
    assign out[1] = w[1];
    assign out[2] = w[2];
    assign out[3] = w[3];
endmodule
module mux_2to1 (
    input a,
    input b,
    input cd,
    output out
);
    assign out = (cd & b) | (~cd & a);
endmodule
