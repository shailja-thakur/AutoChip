module top_module (
    input clk,
    input x,
    output reg z
);

    // Declare flip-flops
    reg q1, q2, q3;

    // D flip-flop logic with different gates (ensure correctness of complemented outputs)
    wire d1 = x ^ q1;          // XOR gate
    wire d2 = x & ~q2;         // AND gate
    wire d3 = x | ~q3;         // OR gate

    // D flip-flop instantiation, update on clock's rising edge
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // Three input XNOR gate, adding complementary operations correctly
    wire xnor_output = ~(q1 ^ q2 ^ q3);

    // Fix: Use non-blocking assignments for output z
    always @(posedge clk) begin
        z <= xnor_output;
    end

endmodule
