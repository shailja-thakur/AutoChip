module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    wire d1, d2, d3;
    wire xn1, xn2, xn3;

    // Logic for D inputs to flip-flops
    assign d1 = x ^ q1;
    assign d2 = x & ~q2;
    assign d3 = x | ~q3;

    // Logic for XNOR output
    assign xn1 = q1;
    assign xn2 = q2;
    assign xn3 = q3;
    
    assign z = ~(xn1 ^ xn2 ^ xn3);

    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

endmodule
