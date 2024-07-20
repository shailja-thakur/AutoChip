module top_module (
    input clk,
    input x,
    output z
);
    // Intermediate wires for the outputs of D flip-flops
    wire q1, q2, q3;
	
    // Intermediate wires for the complemented outputs of D flip-flops
    wire q1_bar, q2_bar, q3_bar;

    // Intermediate wires for the gates' results
    wire xor_result, and_result, or_result;
	
    // D flip-flops
    d_flip_flop DFF1(
        .clk(clk),
        .d(xor_result),
        .q(q1),
        .q_bar(q1_bar)
    );

    d_flip_flop DFF2(
        .clk(clk),
        .d(and_result),
        .q(q2),
        .q_bar(q2_bar)
    );

    d_flip_flop DFF3(
        .clk(clk),
        .d(or_result),
        .q(q3),
        .q_bar(q3_bar)
    );

    // Gates logic
    assign xor_result = x ^ q1;
    assign and_result = x & q2_bar;
    assign or_result  = x | q3_bar;

    // 3-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module d_flip_flop (
    input clk,
    input d,
    output reg q,
    output q_bar
);
    // Reset flip-flop on initialization
    initial begin
        q <= 0;
    end

    // Flip-flop behavior on clock edge
    always @(posedge clk) begin
        q <= d;
    end

    // Complementary output
    assign q_bar = ~q;

endmodule
