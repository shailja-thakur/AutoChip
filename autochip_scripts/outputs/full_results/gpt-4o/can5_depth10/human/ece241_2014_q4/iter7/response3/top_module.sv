module top_module (
    input clk,
    input x,
    output z
);

    // D flip-flop outputs
    reg q1, q2, q3;

    // Initialize flip-flops to zero on reset
    initial begin
        q1 = 0;
        q2 = 0;
        q3 = 0;
    end

    // D flip-flop logic with different gates
    wire d1 = x ^ q1;          // XOR gate with its corresponding flip-flop's output
    wire d2 = x & ~q2;         // AND gate with its corresponding flip-flop's complemented output
    wire d3 = x | ~q3;         // OR gate with its corresponding flip-flop's complemented output

    // Sequential logic to update flip-flop values on clock edge
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // Three-input XNOR gate logic
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
