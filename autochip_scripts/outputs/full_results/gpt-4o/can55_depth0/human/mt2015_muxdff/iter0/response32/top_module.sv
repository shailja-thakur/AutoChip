module mux2to1 (
    input wire sel,
    input wire d0,
    input wire d1,
    output wire y
);
    assign y = sel ? d1 : d0;
endmodule
module dff (
    input wire clk,
    input wire d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module sub_module(
    input wire clk,
    input wire L,
    input wire d0,
    input wire d1,
    input wire r,
    output wire q
);
    wire mux_out;
    wire dff_out;
    
    mux2to1 u_mux (
        .sel(L),
        .d0(d0),
        .d1(r),
        .y(mux_out)
    );

    dff u_dff (
        .clk(clk),
        .d(mux_out),
        .q(dff_out)
    );

    assign q = dff_out;
endmodule
module full_module (
    input wire [2:0] r,
    input wire L,
    input wire clk,
    output wire [2:0] q
);
    sub_module u0 (
        .clk(clk),
        .L(L),
        .d0(q[1] ^ q[2]),
        .d1(q[0]),
        .r(r[0]),
        .q(q[0])
    );

    sub_module u1 (
        .clk(clk),
        .L(L),
        .d0(q[0]),
        .d1(q[0]),
        .r(r[1]),
        .q(q[1])
    );

    sub_module u2 (
        .clk(clk),
        .L(L),
        .d0(q[1]),
        .d1(q[2]),
        .r(r[2]),
        .q(q[2])
    );
endmodule
