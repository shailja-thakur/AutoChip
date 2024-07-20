module mux_2to1 (
    input a,
    input b,
    input sel,
    output y
);
    assign y = sel ? b : a;
endmodule
module d_flipflop (
    input d,
    input clk,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module submodule (
    input a,
    input b,
    input sel,
    input clk,
    output q
);
    wire mux_out;

    mux_2to1 u_mux (
        .a(a),
        .b(b),
        .sel(sel),
        .y(mux_out)
    );

    d_flipflop u_dff (
        .d(mux_out),
        .clk(clk),
        .q(q)
    );
endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);
    submodule u0 (
        .a(q[1] ^ q[2]),
        .b(r[0]),
        .sel(L),
        .clk(clk),
        .q(q[0])
    );

    submodule u1 (
        .a(q[0]),
        .b(r[1]),
        .sel(L),
        .clk(clk),
        .q(q[1])
    );

    submodule u2 (
        .a(q[2]),
        .b(r[2]),
        .sel(L),
        .clk(clk),
        .q(q[2])
    );
endmodule
