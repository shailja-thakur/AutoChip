module top_module (
    input clk,
    input x,
    output z
);

reg d1, d2, d3;
wire d1_bar, d2_bar, d3_bar;

assign d1_bar = ~d1;
assign d2_bar = ~d2;
assign d3_bar = ~d3;

xor x1 (
    .a(x),
    .b(d1),
    .z()
);

and a1 (
    .a(x),
    .b(d2_bar),
    .z()
);

or o1 (
    .a(x),
    .b(d3_bar),
    .z()
);

xor xnor (
    .a(x1_z),
    .b(a1_z),
    .c(o1_z),
    .z(z)
);

always @(posedge clk) begin
    d1 <= x1_z;
    d2 <= a1_z;
    d3 <= o1_z;
end

endmodule
