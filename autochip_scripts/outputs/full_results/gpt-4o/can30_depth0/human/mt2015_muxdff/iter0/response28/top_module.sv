module mux2_1(
    input a,
    input b,
    input sel,
    output y
);
    assign y = sel ? b : a;
endmodule
module d_flipflop(
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
module submodule(
    input clk,
    input L,
    input q_in,
    input r_in,
    output q_out
);
    wire mux_out;
    mux2_1 u_mux (
        .a(q_in),
        .b(r_in),
        .sel(L),
        .y(mux_out)
    );
    d_flipflop u_ff (
        .clk(clk),
        .D(mux_out),
        .Q(q_out)
    );
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire q0, q1, q2;
    
    submodule u0 (
        .clk(clk),
        .L(L),
        .q_in(q1 ^ q2),
        .r_in(r[0]),
        .q_out(q[0])
    );
    
    submodule u1 (
        .clk(clk),
        .L(L),
        .q_in(q0),
        .r_in(r[1]),
        .q_out(q[1])
    );
    
    submodule u2 (
        .clk(clk),
        .L(L),
        .q_in(q2),
        .r_in(r[2]),
        .q_out(q[2])
    );
    
    assign q2 = q[2];
endmodule
