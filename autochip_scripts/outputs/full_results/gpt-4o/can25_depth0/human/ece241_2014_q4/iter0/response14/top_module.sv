module top_module (
    input clk,
    input x,
    output z
);
    reg q1, q2, q3;

    // D flip-flop 1
    wire dff1_d = x ^ q1;
    always @(posedge clk) begin
        q1 <= dff1_d;
    end

    // D flip-flop 2
    wire dff2_d = x & ~q2;
    always @(posedge clk) begin
        q2 <= dff2_d;
    end

    // D flip-flop 3
    wire dff3_d = x | ~q3;
    always @(posedge clk) begin
        q3 <= dff3_d;
    end

    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
