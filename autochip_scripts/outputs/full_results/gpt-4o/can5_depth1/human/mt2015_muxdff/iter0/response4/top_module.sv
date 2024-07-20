module dff_mux(
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg q
);

    always @(posedge clk) begin
        if (L) begin
            q <= r_in;
        end else begin
            q <= q_in;
        end
    end

endmodule
module top_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

    wire q1, q2, q3;

    // Instantiating the dff_mux submodules
    dff_mux dff1 (
        .clk(clk),
        .L(L),
        .r_in(r[0]),
        .q_in(q2 ^ q3),  // q[0]'s next state depends on q[2] XOR q[1]
        .q(q[0])
    );

    dff_mux dff2 (
        .clk(clk),
        .L(L),
        .r_in(r[1]),
        .q_in(q[0]),  // q[1]'s next state is q[0]'s current state
        .q(q[1])
    );

    dff_mux dff3 (
        .clk(clk),
        .L(L),
        .r_in(r[2]),
        .q_in(q[2]),  // q[2]'s next state is its own current state
        .q(q[2])
    );

endmodule
