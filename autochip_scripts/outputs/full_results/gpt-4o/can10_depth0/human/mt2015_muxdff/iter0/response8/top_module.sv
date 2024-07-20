module flipflop_mux (
    input clk,
    input L,
    input d,
    input r,
    output reg q
);
    always @(posedge clk) begin
        if (L) begin
            q <= r;
        end else begin
            q <= d;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    input q_in,
    output [2:0] Q
);
    wire q1, q2, q3;
    wire mux_out1, mux_out2, mux_out3;

    // Instantiate the submodule flipflop_mux three times
    flipflop_mux u1 (.clk(clk), .L(L), .d(q_in), .r(r[0]), .q(q1));
    flipflop_mux u2 (.clk(clk), .L(L), .d(q1), .r(r[1]), .q(q2));
    flipflop_mux u3 (.clk(clk), .L(L), .d(q2), .r(r[2]), .q(q3));

    // Output of top_module
    assign Q = {q3, q2, q1};
endmodule
