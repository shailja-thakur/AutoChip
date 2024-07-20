module top_module (
    input clk,
    input x,
    output z
);
    reg q1, q2, q3;
    wire d1, d2, d3;
    wire q1_bar, q2_bar, q3_bar;

    // D flip-flop for q1
    always @(posedge clk) begin
        q1 <= d1;
    end

    // D flip-flop for q2
    always @(posedge clk) begin
        q2 <= d2;
    end

    // D flip-flop for q3
    always @(posedge clk) begin
        q3 <= d3;
    end

    // Complement of q1, q2, q3
    assign q1_bar = ~q1;
    assign q2_bar = ~q2;
    assign q3_bar = ~q3;

    // XOR gate inputs: x and q1
    assign d1 = x ^ q1;

    // AND gate inputs: x and q2's complement
    assign d2 = x & q2_bar;

    // OR gate inputs: x and q3's complement
    assign d3 = x | q3_bar;

    // XNOR of all outputs of flip-flops
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
