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
 
    always @(state) begin
        B3_next = (state == 10'b1000000000) ? 1'b1 : 1'b0;
        S_next = (state == 10'b0000000001) ? 1'b1 : 1'b0;
        S1_next = (state == 10'b0000000010) ? 1'b1 : 1'b0;
        Count_next = (state == 10'b1000000000) ? 1'b0 : 
                     (state == 10'b0000000010) ? 1'b1 :
                     (state == 10'b0000000100) ? 1'b1 : 1'b0;
        Wait_next = (state == 10'b0000000100) ? 1'b1 : 
                    (state == 10'b1000000001) ? 1'b1 : 1'b0;
    end
    
    always @(state, d, done_counting, ack) begin
        done = (state == 10'b1000000001) ? 1'b1 : 1'b0;
        counting = (state[2:0] == 10'b010) ? 1'b1 : 1'b0;
        shift_ena = (state[2:0] == 10'b000) ? 1'b1 : 
                    (state[2:0] == 10'b001) ? 1'b1 : 
                    (state[2:0] == 10'b010) ? 1'b1 : 1'b0;
    end
 
endmodule
