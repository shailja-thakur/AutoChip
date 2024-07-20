module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3, nq1, nq2, nq3;
    
    // D flip-flops
    dff dff1 (
        .clk(clk),
        .d(q1),
        .q(q1),
        .nq(nq1)
    );
    
    dff dff2 (
        .clk(clk),
        .d(q2),
        .q(q2),
        .nq(nq2)
    );
    
    dff dff3 (
        .clk(clk),
        .d(q3),
        .q(q3),
        .nq(nq3)
    );
    
    // Logic gates
    xor xor1 (q1, x);
    and and1 (nq1, x);
    or or1 (nq1, x);
    
    xor xor2 (q2, x);
    and and2 (nq2, x);
    or or2 (nq2, x);
    
    xor xor3 (q3, x);
    and and3 (nq3, x);
    or or3 (nq3, x);
    
    xnor xnor1 (z, q1, q2, q3);

endmodule
module dff (
    input clk,
    input d,
    output reg q,
    output reg nq
);

    always @(posedge clk) begin
        q <= d;
        nq <= ~d;
    end

endmodule
