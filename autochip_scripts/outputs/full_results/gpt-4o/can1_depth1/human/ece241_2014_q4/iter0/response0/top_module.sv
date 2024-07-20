module top_module (
    input clk,
    input x,
    output z
);

    reg [2:0] q;

    wire d0, d1, d2;
    wire qbar1, qbar2;
    
    // D flip-flops
    always @(posedge clk) begin
        q[0] <= d0;
        q[1] <= d1;
        q[2] <= d2;
    end
    
    assign d0 = x ^ q[0];
    assign qbar1 = ~q[1];
    assign d1 = x & qbar1;
    assign qbar2 = ~q[2];
    assign d2 = x | qbar2;
    
    assign z = ~(q[0] ~^ q[1] ~^ q[2]);

endmodule
