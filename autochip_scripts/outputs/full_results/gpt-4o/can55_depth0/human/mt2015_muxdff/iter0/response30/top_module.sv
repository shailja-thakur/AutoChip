module flipflop_mux (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg q_out
);

    always @(posedge clk) begin
        if (L) begin
            q_out <= r_in;
        end else begin
            q_out <= q_in;
        end
    end

endmodule
module top_module (
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

    wire [2:0] q_internal;

    // Instance 1
    flipflop_mux u0 (
        .clk(clk),
        .L(L),
        .q_in(q[0] ^ q[2]),
        .r_in(r[0]),
        .q_out(q_internal[0])
    );

    // Instance 2
    flipflop_mux u1 (
        .clk(clk),
        .L(L),
        .q_in(q[1]),
        .r_in(r[1]),
        .q_out(q_internal[1])
    );

    // Instance 3
    flipflop_mux u2 (
        .clk(clk),
        .L(L),
        .q_in(q[2]),
        .r_in(r[2]),
        .q_out(q_internal[2])
    );

    always @(posedge clk) begin
        q <= q_internal;
    end

endmodule
