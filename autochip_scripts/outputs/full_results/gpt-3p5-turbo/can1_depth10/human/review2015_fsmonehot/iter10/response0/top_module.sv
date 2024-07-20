module top_module(
    input d,
    input done_counting,
    input ack,
    input clk,
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

    always @(state)
    begin
        // State transition logic
        case (state)
            10'b1000000000: begin B3_next = 1'b0; S_next = 1'b0; S1_next = 1'b0; Count_next = 1'b0; Wait_next = 1'b0; end
            10'b0000000001: begin B3_next = 1'b0; S_next = (d == 1'b0); S1_next = 1'b0; Count_next = 1'b0; Wait_next = 1'b0; end
            10'b0000000010: begin B3_next = 1'b0; S_next = 1'b0; S1_next = (d == 1'b0); Count_next = 1'b0; Wait_next = 1'b0; end
            10'b0000000100: begin B3_next = 1'b0; S_next = (d == 1'b1); S1_next = 1'b0; Count_next = 1'b0; Wait_next = 1'b0; end
            10'b1000000010: begin B3_next = 1'b0; S_next = 1'b0; S1_next = (d == 1'b1); Count_next = 1'b0; Wait_next = 1'b0; end
            10'b1000000100: begin B3_next = 1'b0; S_next = 1'b0; S1_next = 1'b0; Count_next = 1'b1; Wait_next = 1'b0; end
            10'b0100001000: begin B3_next = 1'b0; S_next = 1'b0; S1_next = 1'b0; Count_next = 1'b0; Wait_next = 1'b1; end
            default: begin B3_next = 1'b0; S_next = 1'b0; S1_next = 1'b0; Count_next = 1'b0; Wait_next = 1'b0; end
        endcase
    end

    always @(state)
    begin
        counting = (state[7] | state[8] | state[9]);
        shift_ena = counting;
    end

    always @(posedge clk)
    begin
        if (state == 10'b0100001000)
            done = (done_counting == 1'b1);
        else
            done = 1'b0;
    end

endmodule
