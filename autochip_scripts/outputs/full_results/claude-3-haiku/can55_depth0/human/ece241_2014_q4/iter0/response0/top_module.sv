module top_module (
    input clk,
    input x,
    output z
);

    // Declare the D flip-flops
    reg q1, q2, q3;

    // Combinational logic
    wire xor_out = x ^ q1;
    wire and_out = x & ~q2;
    wire or_out = x | ~q3;

    // Assign the XNOR output
    assign z = ~(xor_out ^ and_out ^ or_out);

    // Sequential logic
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end

endmodule
