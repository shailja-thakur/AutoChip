module top_module (
    input clk,
    input x,
    output z
);

    // Declare wires for the output of flip-flops and their complementary outputs
    reg q_xor, q_and, q_or;
    wire q_xor_n, q_and_n, q_or_n;
    
    // Complementary outputs
    assign q_xor_n = ~q_xor;
    assign q_and_n = ~q_and;
    assign q_or_n = ~q_or;
    
    // XOR gate input and output logic
    wire d_xor;
    assign d_xor = x ^ q_xor;
    
    // AND gate input and output logic
    wire d_and;
    assign d_and = x & q_and_n; 
    
    // OR gate input and output logic
    wire d_or;
    assign d_or = x | q_or_n;
    
    // D flip-flops with synchronous reset (initialized to 0)
    always @(posedge clk) begin
        q_xor <= d_xor;
        q_and <= d_and;
        q_or <= d_or;
    end
    
    // Three-input XNOR gate
    assign z = ~(q_xor ^ q_and ^ q_or);

endmodule
