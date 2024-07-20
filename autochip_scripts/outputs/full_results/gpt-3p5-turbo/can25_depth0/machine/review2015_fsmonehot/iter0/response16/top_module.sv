module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );
    
    // Assign default values to outputs
    assign done = (state == 10'b0);
    assign counting = (state == 10'b1100010000);
    assign shift_ena = (state[3] || state[2] || state[1] || state[0]);
    
    always @(state or d or done_counting or ack) begin
        B3_next = (state[3] == 1'b1);
        S_next = ((state == 10'b0 && d == 1'b0) || 
                  (state == 10'b1 && d == 1'b0) || 
                  (state == 10'b110 && d == 1'b0) ||
                  (state == 10'b10 && d == 1'b0));
        S1_next = ((state == 10'b0 && d == 1'b1));
        Count_next = ((state == 10'b1000 && done_counting == 1'b0) || 
                      (state == 10'b1100010000));
        Wait_next = ((state == 10'b1000 && done_counting == 1'b1) || 
                     (state == 10'b0 && ack == 1'b0));
    end
endmodule
