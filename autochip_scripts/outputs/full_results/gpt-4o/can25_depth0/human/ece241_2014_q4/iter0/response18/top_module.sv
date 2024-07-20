module top_module (
    input clk,
    input x,
    output z
);

    // Declare intermediate signals
    wire d1, d2, d3;
    wire q1, q2, q3;
    wire q1_bar, q2_bar, q3_bar;
    
    // Gate logic
    assign d1 = x ^ q1;            // XOR gate
    assign q1_bar = ~q1;           // Complement output of first DFF
    assign d2 = x & q2_bar;        // AND gate with complementary output of second DFF
    assign q2_bar = ~q2;           // Complement output of second DFF
    assign d3 = x | q3_bar;        // OR gate with complementary output of third DFF
    assign q3_bar = ~q3;           // Complement output of third DFF

    // D flip-flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // XNOR gate with the outputs of the three flip-flops
    assign z = ~(q1 ^ q2 ^ q3);
    
endmodule
