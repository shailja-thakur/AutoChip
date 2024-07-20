module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack);

    // State encoding
    reg [3:0] state, next_state;
    localparam STATE_WAIT     = 4'b0000,
               STATE_DET_1    = 4'b0001,
               STATE_DET_11   = 4'b0010,
               STATE_DET_110  = 4'b0011,
               STATE_DET_1101 = 4'b0100,
               STATE_SHIFT1   = 4'b0101,
               STATE_SHIFT2   = 4'b0110,
               STATE_SHIFT3   = 4'b0111,
               STATE_SHIFT4   = 4'b1000,
               STATE_COUNT    = 4'b1001,
               STATE_DONE     = 4'b1010;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_WAIT;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        next_state = state; // Default to remain in current state
        shift_ena = 0;
        counting = 0;
        done = 0;
        case (state)
            STATE_WAIT: begin
                if (data) next_state = STATE_DET_1;
            end
            STATE_DET_1: begin
                if (!data) next_state = STATE_WAIT;
                else next_state = STATE_DET_11;
            end
            STATE_DET_11: begin
                if (!data) next_state = STATE_WAIT;
                else next_state = STATE_DET_110;
            end
            STATE_DET_110: begin
                if (data) next_state = STATE_DET_1101;
                else next_state = STATE_WAIT;
            end
            STATE_DET_1101: begin
                if (data) next_state = STATE_SHIFT1;
                else next_state = STATE_WAIT;
            end
            STATE_SHIFT1: begin
                shift_ena = 1;
                next_state = STATE_SHIFT2;
            end
            STATE_SHIFT2: begin
                shift_ena = 1;
                next_state = STATE_SHIFT3;
            end
            STATE_SHIFT3: begin
                shift_ena = 1;
                next_state = STATE_SHIFT4;
            end
            STATE_SHIFT4: begin
                shift_ena = 1;
                next_state = STATE_COUNT;
            end
            STATE_COUNT: begin
                counting = 1;
                if (done_counting) next_state = STATE_DONE;
            end
            STATE_DONE: begin
                done = 1;
                if (ack) next_state = STATE_WAIT;
            end
            default: next_state = STATE_WAIT;
        endcase
    end
endmodule
