module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;

    // D-FF 1
    wire d1 = x ^ q1;
    always @(posedge clk) begin
        q1 <= d1;
    end

    // D-FF 2
    wire d2 = x & ~q2;
    always @(posedge clk) begin
        q2 <= d2;
    end

    // D-FF 3
    wire d3 = x | ~q3;
    always @(posedge clk) begin
        q3 <= d3;
    end

    // XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
