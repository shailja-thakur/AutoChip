module mux_2to1 (
    input a,
    input b,
    input sel,
    output y
);
    assign y = sel ? b : a;
endmodule
module flipflop (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module sub_module (
    input clk,
    input L,
    input data,
    input r_in,
    output q_out
);
    wire mux_out;
    
    mux_2to1 m (
        .a(data),
        .b(r_in),
        .sel(L),
        .y(mux_out)
    );

    flipflop ff (
        .clk(clk),
        .d(mux_out),
        .q(q_out)
    );
endmodule
module top_module (
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire q0, q1, q2;

    sub_module u0 (
        .clk(clk),
        .L(L),
        .data(q1 ^ q2),
        .r_in(r[0]),
        .q_out(q0)
    );

    sub_module u1 (
        .clk(clk),
        .L(L),
        .data(q0),
        .r_in(r[1]),
        .q_out(q1)
    );

    sub_module u2 (
        .clk(clk),
        .L(L),
        .data(q2),
        .r_in(r[2]),
        .q_out(q2)
    );

    assign q = {q2, q1, q0};
endmodule
