module top_module (
    input clk,
    input x,
    output z
);

    // Declare three D flip-flops
    reg q1, q2, q3;

    // Combinational logic for the three gates
    wire xor_out = x ^ q1;
    wire and_out = x & ~q2;
    wire or_out = x | ~q3;

    // Assign the D inputs of the flip-flops
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end

    // Combinational logic for the XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
