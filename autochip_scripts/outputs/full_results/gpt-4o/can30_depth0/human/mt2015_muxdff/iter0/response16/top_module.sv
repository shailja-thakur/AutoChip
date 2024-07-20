module mux_dff (
    input clk,
    input L,
    input r_in,
    input q_dff,
    output reg Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_dff;
        end
    end
endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

    wire [2:0] q_int; // intermediate signals for feedback

    mux_dff u0 (
        .clk(clk),
        .L(L),
        .r_in(r[0]),
        .q_dff(q[0]),
        .Q(q_int[0])
    );

    mux_dff u1 (
        .clk(clk),
        .L(L),
        .r_in(r[1]),
        .q_dff(q[1]),
        .Q(q_int[1])
    );

    mux_dff u2 (
        .clk(clk),
        .L(L),
        .r_in(r[2]),
        .q_dff(q[2]),
        .Q(q_int[2])
    );

    assign q = {q_int[1] ^ q_int[2], q_int[0], q_int[2]};

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    // Instantiate full_module
    wire [2:0] q;
    wire [2:0] r;
    assign r = {r_in, r_in, r_in}; // multiplex r_in into required bits
    assign q = {q_in, q_in, q_in}; // multiplex q_in into required bits

    full_module full_inst (
        .r(r),
        .L(L),
        .clk(clk),
        .q(q)
    );

    // single bit assignment for the output Q
    always @(*) begin
        Q = q[2]; // or any q[x] for required bit
    end
endmodule
