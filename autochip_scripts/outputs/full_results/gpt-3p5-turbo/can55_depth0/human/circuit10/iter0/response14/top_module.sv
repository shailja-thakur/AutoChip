module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    reg q_d, q_next;
    reg state_d, state_next;
    
    always @(posedge clk)
    begin
        q_d <= q_next;
        state_d <= state_next;
    end
    
    always @*
    begin
        q_next = a;
        state_next = (state_d & ~b) | (q_d & b);
    end
    
    assign q = q_d;
    assign state = state_d;

endmodule
