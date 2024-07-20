module top_module (
    input clk,
    input x,
    output z
);

    wire d1, d2, d3;
    reg q1, q2, q3;
    wire q1_bar, q2_bar, q3_bar;
    wire xnor_in1, xnor_in2, xnor_in3;

    // D Flip-Flop 1
    assign d1 = x ^ q1;   // XOR gate
    always @(posedge clk) begin
        q1 <= d1;
    end

    // D Flip-Flop 2
    assign d2 = x & ~q2;  // AND gate with complemented output
    always @(posedge clk) begin
        q2 <= d2;
    end

    // D Flip-Flop 3
    assign d3 = x | ~q3;  // OR gate with complemented output
    always @(posedge clk) begin
        q3 <= d3;
    end

    // Complemented outputs
    assign q1_bar = ~q1;
    assign q2_bar = ~q2;
    assign q3_bar = ~q3;

    // Three-input XNOR gate
    assign xnor_in1 = q1;
    assign xnor_in2 = q2;
    assign xnor_in3 = q3;
    assign z = ~(xnor_in1 ^ xnor_in2 ^ xnor_in3);

endmodule
