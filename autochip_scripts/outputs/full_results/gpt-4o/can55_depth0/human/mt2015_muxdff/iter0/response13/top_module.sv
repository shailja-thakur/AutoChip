module sub_module (
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
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);
    wire q0_in, q1_in, q2_in;
    wire q0_out, q1_out, q2_out;

    // Combinational logic for the XOR feedback loop
    assign q0_in = q1_out ^ q2_out;
    assign q1_in = q0_out;
    assign q2_in = q2_out;

    // Instantiate sub_module for each bit
    sub_module u0 (.clk(clk), .L(L), .q_in(q0_in), .r_in(r[0]), .Q(q0_out));
    sub_module u1 (.clk(clk), .L(L), .q_in(q1_in), .r_in(r[1]), .Q(q1_out));
    sub_module u2 (.clk(clk), .L(L), .q_in(q2_in), .r_in(r[2]), .Q(q2_out));

    // Assign outputs
    assign q = {q2_out, q1_out, q0_out};
endmodule
