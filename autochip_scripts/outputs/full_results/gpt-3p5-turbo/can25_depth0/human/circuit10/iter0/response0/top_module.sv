module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);
    reg state;
    reg q;
    reg q_next;
    
    always @(posedge clk) begin
        state <= q_next;
        q <= q_next;
    end
    
    always @(a, b, state) begin
        q_next = (state & (~a | b));
    end
endmodule
