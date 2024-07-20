module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3, qbar1, qbar2, qbar3;
    wire xor_out, and_out, or_out;

    // D Flip-Flops
    dff dff1 (.clk(clk), .d(xor_out), .q(q1), .qbar(qbar1));
    dff dff2 (.clk(clk), .d(and_out), .q(q2), .qbar(qbar2));
    dff dff3 (.clk(clk), .d(or_out), .q(q3), .qbar(qbar3));

    // Gates
    assign xor_out = x ^ q1;
    assign and_out = x & qbar2;
    assign or_out = x | qbar3;

    // XNOR
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
    input clk,
    input d,
    output reg q,
    output reg qbar
);

    always @(posedge clk) begin
        q <= d;
        qbar <= ~d;
    end

endmodule
