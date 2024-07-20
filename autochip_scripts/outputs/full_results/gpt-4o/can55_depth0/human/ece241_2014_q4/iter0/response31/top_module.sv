module top_module (
    input clk,
    input x,
    output z
);

    // Declare wires for flip-flop outputs and their complements
    wire q1, q2, q3;
    wire nq1, nq2, nq3;

    // Instantiate the D flip-flops with initial reset value 0
    reg r1, r2, r3;
    initial begin
        r1 = 0;
        r2 = 0;
        r3 = 0;
    end

    // Assign flip-flop outputs to wires
    assign q1 = r1;
    assign q2 = r2;
    assign q3 = r3;

    // Compute complements of the flip-flop outputs
    assign nq1 = ~q1;
    assign nq2 = ~q2;
    assign nq3 = ~q3;

    // Compute the D inputs for flip-flops
    wire d1, d2, d3;
    assign d1 = x ^ q1;
    assign d2 = x & nq2;
    assign d3 = x | nq3;

    // Flip-flops logic
    always @(posedge clk) begin
        r1 <= d1;
        r2 <= d2;
        r3 <= d3;
    end

    // Compute the XNOR gate output
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
