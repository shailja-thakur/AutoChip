module top_module (
    input clk,
    input x,
    output z
);
    
    // Declare internal wires
    wire xor_d, and_d, or_d;
    wire q1, q2, q3;
    wire nq1, nq2, nq3;

    // Declare flip-flops
    reg dff1, dff2, dff3;
    
    // Output of D flip-flops
    assign q1 = dff1;
    assign q2 = dff2;
    assign q3 = dff3;
    
    // Complementary outputs of flip-flops
    assign nq1 = ~dff1;
    assign nq2 = ~dff2;
    assign nq3 = ~dff3;

    // Combinational logic for D inputs of flip-flops
    assign xor_d = x ^ q1;
    assign and_d = x & nq2;
    assign or_d = x | nq3;
    
    // D flip-flops
    always @(posedge clk) begin
        dff1 <= xor_d;
        dff2 <= and_d;
        dff3 <= or_d;
    end
    
    // 3-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
