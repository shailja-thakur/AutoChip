module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);
    
    reg q_n;
    always @(posedge clk) begin
        q_n <= (a & ~b) | (state & ~a);
    end
    
    always @(posedge clk) begin
        state <= q;
    end
    
    assign q = q_n;

endmodule
