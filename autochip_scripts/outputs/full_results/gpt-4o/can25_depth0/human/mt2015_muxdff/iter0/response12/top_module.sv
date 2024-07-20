module submodule (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] q_in,
    input [2:0] r_in,
    output reg [2:0] Q
);
    wire [2:0] q_next;

    // Instantiate the submodule three times
    submodule u0 (
        .clk(clk),
        .L(L),
        .q_in(q_in[0] ^ q_in[2]),  // XOR of q1 and q2
        .r_in(r_in[0]),
        .Q(q_next[0])
    );

    submodule u1 (
        .clk(clk),
        .L(L),
        .q_in(q_in[0]),            // Pass q0
        .r_in(r_in[1]),
        .Q(q_next[1])
    );

    submodule u2 (
        .clk(clk),
        .L(L),
        .q_in(q_in[2]),            // Pass q2
        .r_in(r_in[2]),
        .Q(q_next[2])
    );

    always @(posedge clk) begin
        Q <= q_next;
    end
endmodule
