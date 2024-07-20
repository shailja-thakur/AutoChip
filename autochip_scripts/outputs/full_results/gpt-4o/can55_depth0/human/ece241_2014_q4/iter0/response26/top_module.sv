module top_module (
    input clk,
    input x,
    output z
);

    reg D1, D2, D3;
    wire Q1, Q2, Q3;
    wire Q1_bar, Q2_bar, Q3_bar;
    wire x_xor_Q1, x_and_Q2_bar, x_or_Q3_bar;

    // Instantiate the D flip-flops
    always @(posedge clk) begin
        D1 <= x_xor_Q1;
        D2 <= x_and_Q2_bar;
        D3 <= x_or_Q3_bar;
    end
    
    // D flip-flop outputs
    assign Q1 = D1;
    assign Q2 = D2;
    assign Q3 = D3;
    
    // Complementary outputs
    assign Q1_bar = ~Q1;
    assign Q2_bar = ~Q2;
    assign Q3_bar = ~Q3;
    
    // Gate computations
    assign x_xor_Q1 = x ^ Q1;
    assign x_and_Q2_bar = x & Q2_bar;
    assign x_or_Q3_bar = x | Q3_bar;
    
    // Three-input XNOR gate for the output
    assign z = ~(Q1 ^ Q2 ^ Q3);

endmodule
