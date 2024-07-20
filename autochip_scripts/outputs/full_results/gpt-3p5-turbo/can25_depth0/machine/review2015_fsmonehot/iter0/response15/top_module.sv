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

    // State signals
    reg [9:0] next_state;

    // Update the next state based on the current state and input signals
    always @(state, d, ack, done_counting) begin
        case(state)
            // Update next_state based on current state and input signals
            10'b0000000001: begin        // S
                if (d == 0 || ack == 1)
                    next_state = 10'b0000000001;    // Stay in S
                else
                    next_state = 10'b0000000010;    // Move to S1
            end
            10'b0000000010: begin        // S1
                if (d == 1)
                    next_state = 10'b0000000001;    // Move back to S
                else
                    next_state = 10'b0000000110;    // Move to S110
            end
            10'b0000000110: begin        // S110
                if (d == 0)
                    next_state = 10'b0000000001;    // Move back to S
                else
                    next_state = 10'b0000000000;    // Move to Wait
            end
            10'b0000000000: begin        // Wait
                if (ack == 0)
                    next_state = 10'b0000000000;    // Stay in Wait
                else
                    next_state = 10'b0000000100;    // Move to B0
            end
            10'b0000000100: begin        // B0
                next_state = 10'b0000000101;    // Move to B1
            end
            10'b0000000101: begin        // B1
                next_state = 10'b0000000111;    // Move to B3
            end
            10'b0000000111: begin        // B3
                if (done_counting == 0)
                    next_state = 10'b0000000111;    // Stay in B3
                else
                    next_state = 10'b0000001000;    // Move to Count
            end
            10'b0000001000: begin        // Count
                if (done_counting == 1)
                    next_state = 10'b0000000000;    // Move to Wait
                else
                    next_state = 10'b0000001000;    // Stay in Count
            end
            default: begin
                next_state = 10'b0000000000;    // Default to Wait
            end
        endcase
    end

    // Update output signals based on current state
    always @(state) begin
        B3_next = (state == 10'b0000000010) ? 1'b1 : 1'b0;
        S_next = ((state == 10'b0000000001 && d == 0) || (state == 10'b0000000010 && d == 0) || (state == 10'b0000000110 && d == 0) || (state == 10'b0000000000 && ack == 1)) ? 1'b1 : 1'b0;
        S1_next = (state == 10'b0000000001 && d == 1) ? 1'b1 : 1'b0;
        Count_next = (state == 10'b0000000111 || (state == 10'b0000001000 && done_counting == 0)) ? 1'b1 : 1'b0;
        Wait_next = ((state == 10'b0000001000 && done_counting == 1) || (state == 10'b0000000000 && ack == 0)) ? 1'b1 : 1'b0;
        done = (state == 10'b0000000000) ? 1'b1 : 1'b0;
        counting = (state == 10'b0000001000) ? 1'b1 : 1'b0;
        shift_ena = (state[3:0] == 4'b1111) ? 1'b1 : 1'b0;
    end

    // Update the state
    always @(posedge clk) begin
        state <= next_state;
    end

endmodule
