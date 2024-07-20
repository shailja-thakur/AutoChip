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
    
    // State transition logic
    always @* begin
        B3_next = (state == 10'b0111111111);
        S_next = (state == 10'b0000000001 && d == 1'b0) ? 1'b1 : 1'b0;
        S1_next = (state == 10'b0000000010 && d == 1'b0) ? 1'b1 : (state == 10'b0000000001 && d == 1'b1) ? 1'b1 : (S1_next && d) ? 1'b1 : 1'b0;
        Count_next = (state == 10'b1000000000 && done_counting == 1'b0) ? 1'b1 : (state == 10'b1000000000 && done_counting == 1'b1) ? 1'b1 : (Count_next && !done_counting) ? 1'b1 : 1'b0;
        Wait_next = (state == 10'b1000000010 && done == 1'b1 && ack == 1'b0) ? 1'b1 : (state == 10'b1000000010 && done == 1'b1 && ack == 1'b1) ? 1'b1 : (Wait_next && done && !ack) ? 1'b1 : 1'b0;
    end
    
    // Output logic
    always @* begin
        done = (state == 10'b1000000010);
        counting = (state == 10'b1000000000 || state == 10'b1000000010);
        shift_ena = (state >= 10'b0000000001 && state <= 10'b0000000100);
    end
endmodule
