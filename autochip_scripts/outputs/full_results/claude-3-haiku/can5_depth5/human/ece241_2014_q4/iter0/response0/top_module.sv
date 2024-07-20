module top_module (
    input clk,
    input x,
    output z
);

    reg [2:0] state;

    // Flip-flop outputs
    wire q1, q2, q3;
    wire q1_bar, q2_bar, q3_bar;

    // Combinational logic
    wire xor_out = x ^ q1;
    wire and_out = x & q2_bar;
    wire or_out = x | q3_bar;

    // D flip-flops
    always @(posedge clk) begin
        state[0] <= xor_out;
        state[1] <= and_out;
        state[2] <= or_out;
    end

    // Assign flip-flop outputs
    assign q1 = state[0];
    assign q2 = state[1];
    assign q3 = state[2];
    assign q1_bar = ~q1;
    assign q2_bar = ~q2;
    assign q3_bar = ~q3;

    // Output logic
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
