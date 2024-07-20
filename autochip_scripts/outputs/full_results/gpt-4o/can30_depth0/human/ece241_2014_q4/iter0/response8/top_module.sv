module top_module (
    input clk,
    input x,
    output z
);

    // Create wires for the flip-flop outputs
    wire q1, q2, q3;

    // Create wires for the complemented flip-flop outputs
    wire nq1, nq2, nq3;

    // XOR gate
    wire d1 = x ^ q1;
    
    // AND gate with complemented flip-flop output
    wire d2 = x & nq2;
    
    // OR gate with complemented flip-flop output
    wire d3 = x | nq3;

    // Instantiate D flip-flops with positive edge clock triggered and asynchronous reset
    dff dff1 (
        .clk(clk),
        .d(d1),
        .q(q1),
        .qn(nq1)
    );

    dff dff2 (
        .clk(clk),
        .d(d2),
        .q(q2),
        .qn(nq2)
    );

    dff dff3 (
        .clk(clk),
        .d(d3),
        .q(q3),
        .qn(nq3)
    );
    
    // XNOR gate for the three D flip-flop outputs
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
    input clk,
    input d,
    output reg q,
    output nq
);
    always @(posedge clk) begin
        q <= d;
    end

    assign nq = ~q;
endmodule
