module top_module (
    input clk,
    input x,
    output reg z   // Change output type to reg for procedural assignment
);

    reg q1, q2, q3;

    // D flip-flop logic with different gates
    wire d1 = x ^ q1;          // XOR gate
    wire d2 = x & ~q2;         // AND gate with complemented output
    wire d3 = x | ~q3;         // OR gate with complemented output

    // D flip-flop instantiation
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
        z <= ~(q1 ^ q2 ^ q3);  // Moving the XNOR logic inside the always block to ensure z is updated correctly
    end

endmodule
