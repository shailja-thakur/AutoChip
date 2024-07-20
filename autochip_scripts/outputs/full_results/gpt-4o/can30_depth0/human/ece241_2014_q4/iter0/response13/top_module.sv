module top_module (
    input clk,
    input x,
    output z
);

    reg d1, d2, d3;

    wire xor_out, and_out, or_out;
    wire d1_q, d2_q, d3_q, d1_qn, d2_qn, d3_qn;

    // D flip-flops with asynchronous reset
    always @(posedge clk) begin
        d1 <= xor_out;
        d2 <= and_out;
        d3 <= or_out;
    end

    assign d1_q = d1;
    assign d1_qn = ~d1;
    assign d2_q = d2;
    assign d2_qn = ~d2;
    assign d3_q = d3;
    assign d3_qn = ~d3;

    assign xor_out = x ^ d1_q;
    assign and_out = x & d2_qn;
    assign or_out = x | d3_qn;

    assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
