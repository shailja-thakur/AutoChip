module mux2to1 (
    input a,
    input b,
    input sel,
    output y
);
    assign y = sel ? b : a;
endmodule
module dff (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module submodule (
    input clk,
    input L,
    input q_in,
    input r_in,
    output q_out
);
    wire mux_out;
    mux2to1 u_mux (
        .a(q_in),
        .b(r_in),
        .sel(L),
        .y(mux_out)
    );

    dff u_dff (
        .clk(clk),
        .d(mux_out),
        .q(q_out)
    );
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] q_next;
    
    assign q_next[0] = q[1] ^ q[2]; // Feedback signals for the shift register
    assign q_next[1] = q[0];
    assign q_next[2] = q[2];

    submodule u_submodule0 (
        .clk(clk),
        .L(L),
        .q_in(q_next[0]),
        .r_in(r[0]),
        .q_out(q[0])
    );

    submodule u_submodule1 (
        .clk(clk),
        .L(L),
        .q_in(q_next[1]),
        .r_in(r[1]),
        .q_out(q[1])
    );

    submodule u_submodule2 (
        .clk(clk),
        .L(L),
        .q_in(q_next[2]),
        .r_in(r[2]),
        .q_out(q[2])
    );
endmodule
