module top_module (
    input clk,
    input x,
    output z
);

    reg d1, d2, d3;
    wire q1, q2, q3;
    wire nq1, nq2, nq3;

    // D flip-flops
    always @(posedge clk) begin
        d1 <= x;
        d2 <= x;
        d3 <= x;
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // Complement the flip-flop outputs
    assign nq1 = ~q1;
    assign nq2 = ~q2;
    assign nq3 = ~q3;

    // Logic gates
    wire xor_out, and_out, or_out;
    assign xor_out = x ^ q1;
    assign and_out = x & nq2;
    assign or_out = x | nq3;

    // 3-input XNOR gate
    assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
