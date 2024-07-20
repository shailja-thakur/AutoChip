module top_module (
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

    wire q0, q1, q2;

    sub_module u0 (.clk(clk), .L(L), .r_in(r[0]), .q_in(q2), .q_out(q0));
    sub_module u1 (.clk(clk), .L(L), .r_in(r[1]), .q_in(q0), .q_out(q1));
    sub_module u2 (.clk(clk), .L(L), .r_in(r[2]), .q_in(q1), .q_out(q2));

    assign q = {q2, q1, q0};

endmodule
module sub_module (
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg q_out
);

    wire mux_out;

    assign mux_out = L ? r_in : q_in;

    always @(posedge clk) begin
        q_out <= mux_out;
    end

endmodule
