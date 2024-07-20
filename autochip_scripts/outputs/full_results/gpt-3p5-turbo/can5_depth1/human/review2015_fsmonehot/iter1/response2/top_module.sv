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
    always @(*) begin
        case(state)
            10'b0111111111: B3_next = 1'b1;   // Transition to B3 if current state is B2
            10'b0000000001: S_next = 1'b1;    // Transition to S if current state is B3
            10'b0000000010: S1_next = 1'b1;   // Transition to S1 if current state is S
            10'b1000000000: Count_next = !done_counting;   // Transition to Count if current state is B3 and done_counting is not set, otherwise stay in Count
            10'b1000000100: Wait_next = ack;   // Transition to Wait if current state is B3 and ack is set, otherwise stay in Wait
            default: begin
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        case(state)
            10'b1000000000: done = 1'b1;   // Set done output when current state is Count
            default: done = 1'b0;
        endcase

        counting = state[9];   // Set counting output based on the highest bit of the current state

        case(state)
            10'b1000000100: shift_ena = 1'b1;   // Set shift_ena output when current state is Wait
            default: shift_ena = 1'b0;
        endcase
    end

endmodule
