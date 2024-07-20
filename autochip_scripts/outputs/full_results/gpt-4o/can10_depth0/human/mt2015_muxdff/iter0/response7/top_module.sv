module flipflop_and_mux (
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
    input [2:0] r,
    output [2:0] q
);

    // Internal signals to connect submodules
    wire q0, q1, q2;
    wire mux_out1, mux_out2, mux_out3;

    // Connections from each bit of q for the feedback of LFSR process
    assign mux_out1 = q2 ^ q1;
    assign mux_out2 = q0;
    assign mux_out3 = q2;

    // Instantiate three submodules for each bit
    flipflop_and_mux ffm0(
        .clk(clk),
        .L(L),
        .q_in(mux_out1),   // Feedback wire
        .r_in(r[0]),
        .Q(q[0])
    );

    flipflop_and_mux ffm1(
        .clk(clk),
        .L(L),
        .q_in(mux_out2),   // Feedback wire
        .r_in(r[1]),
        .Q(q[1])
    );

    flipflop_and_mux ffm2(
        .clk(clk),
        .L(L),
        .q_in(mux_out3),   // Feedback wire
        .r_in(r[2]),
        .Q(q[2])
    );

endmodule
