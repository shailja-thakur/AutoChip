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

    always @(*) begin
        // Default assignments
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        done = 0;
        counting = 0;
        shift_ena = 0;

        // Assign outputs based on current state
        case (state)
            10'b0000000001: begin // State S
                S_next = !d;
                S1_next = d;
            end
            10'b0000000010: begin // State S1
                S_next = !d;
            end
            10'b0000000100: begin // State S11
                S_next = !d;
            end
            10'b0000001000: begin // State S110
                S_next = !d;
            end
            10'b0000010000: begin // State B0
                shift_ena = 1;
            end
            10'b0000100000: begin // State B1
                shift_ena = 1;
            end
            10'b0001000000: begin // State B2
                B3_next = 1;
                shift_ena = 1;
            end
            10'b0010000000: begin // State B3
                Count_next = 1;
                shift_ena = 1;
            end
            10'b0100000000: begin // State Count
                counting = 1;
                Count_next = !done_counting;
                Wait_next = done_counting;
            end
            10'b1000000000: begin // State Wait
                done = 1;
                Wait_next = !ack;
            end
        endcase
    end

endmodule
