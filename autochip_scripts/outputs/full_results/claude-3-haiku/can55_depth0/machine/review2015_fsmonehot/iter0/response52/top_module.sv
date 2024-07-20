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
        // Default values
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;

        // Assign outputs based on the current state
        if (state[0]) begin // State S
            S_next = ~d;
        end
        else if (state[1]) begin // State S1
            S1_next = d;
        end
        else if (state[2]) begin // State S11
            // No outputs to be set
        end
        else if (state[3]) begin // State S110
            S_next = ~d;
        end
        else if (state[4]) begin // State B0
            shift_ena = 1'b1;
        end
        else if (state[5]) begin // State B1
            shift_ena = 1'b1;
        end
        else if (state[6]) begin // State B2
            shift_ena = 1'b1;
            B3_next = 1'b1;
        end
        else if (state[7]) begin // State B3
            shift_ena = 1'b1;
            Count_next = 1'b1;
        end
        else if (state[8]) begin // State Count
            counting = 1'b1;
            Count_next = ~done_counting;
            Wait_next = done_counting;
        end
        else if (state[9]) begin // State Wait
            done = 1'b1;
            Wait_next = ~ack;
        end
    end
endmodule
