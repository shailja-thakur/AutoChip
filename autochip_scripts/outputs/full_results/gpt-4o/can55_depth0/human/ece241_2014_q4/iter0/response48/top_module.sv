module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    
    wire xor_out, and_out, or_out;
    wire q1_bar, q2_bar, q3_bar;
    wire xnor_out;

    // Complemented outputs of the flip-flops
    assign q1_bar = ~q1;
    assign q2_bar = ~q2;
    assign q3_bar = ~q3;

    // Input gates
    assign xor_out = x ^ q1;
    assign and_out = x & q2_bar;
    assign or_out = x | q3_bar;

    // D Flip-flops
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end

    // Three-input XNOR
    assign xnor_out = ~(q1 ^ q2 ^ q3);

    // Output Z
    assign z = xnor_out;

endmodule
