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
    output wire counting,
    output wire shift_ena
 );

always @(state) begin
    case(state)
        10'b0000000001: begin // S
            S_next = ~d;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000000010: begin // S1
            S_next = 1'b0;
            S1_next = d;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000000100: begin // S11
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000001000: begin // S110
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000010000: begin // B0
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = shift_ena;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000100000: begin // B1
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = shift_ena;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0001000000: begin // B2
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = shift_ena;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0010000000: begin // B3
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = shift_ena;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0100000000: begin // Count
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = counting & ~done_counting;
            Wait_next = 1'b0;
        end
        10'b1000000000: begin // Wait
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = counting;
            Wait_next = done;
        end
        default: begin // Idle
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
    endcase
end

assign done = state[9] & ack;
assign counting = state[8];
assign shift_ena = (state[6] | state[7] | state[8] | state[9]);
 
endmodule
