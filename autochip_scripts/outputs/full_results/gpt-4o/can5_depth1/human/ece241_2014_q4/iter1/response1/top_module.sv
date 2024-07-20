module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;

    // D flip-flops with correct initial reset
    always @(posedge clk) begin
        q1 <= x ^ q1;         // XOR with current q1
        q2 <= x & ~q2;        // AND with inverted q2
        q3 <= x | ~q3;        // OR with inverted q3
    end

    // Combinational output logic
    assign z = ~(q1 ^ q2 ^ q3);  // 3-input XNOR

endmodule
