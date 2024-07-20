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
    output counting,
    output shift_ena
 );

always @(*)
begin
    case (state)
        10'b0000000001: begin
            B3_next = 1'b0;
            S_next = d ? 1'b0 : 1'b1;
            S1_next = d ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000000010: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = d ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000000100: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = d ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0010000000: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = done_counting ? 1'b1 : 1'b0;
        end
        10'b0100000000: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = done_counting ? 1'b1 : 1'b0;
        end
        10'b1000000000: begin
            B3_next = shift_ena ? 1'b1 : 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        default: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
    endcase
end

always @(posedge clk)
begin
    done = (state[9] & ack) ? 1'b1 : 1'b0;
    counting = state[8]; 
    shift_ena = (state[6] | state[7] | state[8] | state[9]) ? 1'b1 : 1'b0;
end

endmodule
