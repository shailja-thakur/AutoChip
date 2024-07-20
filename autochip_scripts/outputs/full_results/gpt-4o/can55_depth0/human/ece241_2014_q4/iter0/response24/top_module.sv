module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;

    wire q1_next = x ^ q1;          // D input for the first flip-flop
    wire q2_next = x & ~q2;         // D input for the second flip-flop
    wire q3_next = x | ~q3;         // D input for the third flip-flop

    always @(posedge clk) begin
        q1 <= q1_next;
        q2 <= q2_next;
        q3 <= q3_next;
    end

    assign z = ~(q1 ^ q2 ^ q3);     // Output z is the XNOR of the flip-flop outputs

endmodule
