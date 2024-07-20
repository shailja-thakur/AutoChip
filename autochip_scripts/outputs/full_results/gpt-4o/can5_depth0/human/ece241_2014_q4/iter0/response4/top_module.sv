module top_module (
    input clk,
    input x,
    output z
);

    // D flip-flops
    reg q1, q2, q3;
    
    // Internal nets for the logic gates
    wire xor_out, and_out, or_out;
    wire q1_bar, q2_bar, q3_bar;
    
    // Complemented outputs of the flip-flops
    assign q1_bar = ~q1;
    assign q2_bar = ~q2;
    assign q3_bar = ~q3;
    
    // Gate logic
    assign xor_out = x ^ q1;
    assign and_out = x & q2_bar;
    assign or_out = x | q3_bar;

    // D flip-flops update on clock edge
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end

    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
