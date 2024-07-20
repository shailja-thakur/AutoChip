module flipflop_mux(
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

    wire q1, q2, q3;
    wire d1, d2, d3;

    // Control logic for feedback
    assign d1 = q2 ^ q3;
    assign d2 = q1;
    assign d3 = q3;

    // Instantiate flip-flop with mux for each bit
    flipflop_mux u1 (.clk(clk), .L(L), .q_in(d1), .r_in(r[0]), .Q(q[0]));
    flipflop_mux u2 (.clk(clk), .L(L), .q_in(d2), .r_in(r[1]), .Q(q[1]));
    flipflop_mux u3 (.clk(clk), .L(L), .q_in(d3), .r_in(r[2]), .Q(q[2]));

endmodule
