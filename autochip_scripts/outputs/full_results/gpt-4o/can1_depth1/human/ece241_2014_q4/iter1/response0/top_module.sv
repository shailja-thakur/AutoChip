module top_module (
    input clk,
    input x,
    output z
);

    reg q0, q1, q2;
    wire q0_bar, q1_bar, q2_bar;
    
    wire d0, d1, d2;
    
    // D flip-flops
    always @(posedge clk) begin
        q0 <= d0;
        q1 <= d1;
        q2 <= d2;
    end

    assign q0_bar = ~q0;
    assign q1_bar = ~q1;
    assign q2_bar = ~q2;

    assign d0 = x ^ q0;
    assign d1 = x & q1_bar;
    assign d2 = x | q2_bar;
    
    assign z = ~(q0 ~^ q1 ~^ q2);

endmodule
