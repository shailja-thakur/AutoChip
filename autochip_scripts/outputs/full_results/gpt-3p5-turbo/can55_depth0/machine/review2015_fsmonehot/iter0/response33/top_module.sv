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

    reg [9:0] next_state;
    
    always @(*)
    begin
        B3_next = (state[B2] == 1) ? 1'b1 : 1'b0;
        S_next = ((state[S] == 1 && d == 0) || (state[S1] == 1 && d == 0) || (state[S110] == 1 && d == 0) || (state[Wait] == 1 && ack == 1)) ? 1'b1 : 1'b0;
        S1_next = (state[S] == 1 && d == 1) ? 1'b1 : 1'b0;
        Count_next = ((state[B3] == 1) || (state[Count] == 1 && done_counting == 0)) ? 1'b1 : 1'b0;
        Wait_next = ((state[Count] == 1 && done_counting == 1) || (state[Wait] == 1 && ack == 0)) ? 1'b1 : 1'b0;
    end
    
    always @(posedge clk)
    begin
        if (reset)
            state <= 10'b0;
        else
            state <= next_state;
    end
    
    always @(*)
    begin
        shift_ena = (state[B3] || state[B2] || state[B1] || state[B0]) ? 1'b1 : 1'b0;
        done = (state[Wait] == 1) ? 1'b1 : 1'b0;
        counting = (state[Count] == 1) ? 1'b1 : 1'b0;
    end

endmodule
