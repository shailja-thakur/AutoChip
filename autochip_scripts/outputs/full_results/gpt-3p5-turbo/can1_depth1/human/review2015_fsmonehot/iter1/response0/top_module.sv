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

always @(d, done_counting, ack, state) begin
    case(state)
        10'b0000000001: begin // S
            B3_next = 0;
            S_next = d ? 10'b0000000010 : 10'b0000000001;
            S1_next = d ? 10'b0000000100 : 10'b0000000001;
            Count_next = 0;
            Wait_next = 10'b0000000001;
        end
        10'b0000000010: begin // S1
            B3_next = 0;
            S_next = d ? 10'b0000000010 : 10'b0000000001;
            S1_next = d ? 10'b0000000010 : 10'b0000000100;
            Count_next = 0;
            Wait_next = 10'b0000000100;
        end
        10'b0000000100: begin // S11
            B3_next = 0;
            S_next = d ? 10'b0000000010 : 10'b0000000001;
            S1_next = d ? 10'b0000000100 : 10'b0000000100;
            Count_next = 0;
            Wait_next = 10'b0000001000;
        end
        10'b0000001000: begin // S110
            B3_next = 0;
            S_next = d ? 10'b0000000010 : 10'b0000000001;
            S1_next = d ? 10'b0000000100 : 10'b0000000100;
            Count_next = 0;
            Wait_next = done_counting ? 10'b1000000000 : 10'b0000010000;
        end
        10'b0000000010: begin // B0
            B3_next = 10'b0000000001;
            S_next = 10'b0000000001;
            S1_next = 10'b0000000001;
            Count_next = 10'b0000000010;
            Wait_next = 10'b0000000010;
        end
        10'b0000000100: begin // B1
            B3_next = 10'b0000000001;
            S_next = 10'b0000000001;
            S1_next = 10'b0000000001;
            Count_next = 10'b0000000010;
            Wait_next = 10'b0000000100;
        end
        10'b0000001000: begin // B2
            B3_next = 10'b0000000001;
            S_next = 10'b0000000001;
            S1_next = 10'b0000000001;
            Count_next = 10'b0000000010;
            Wait_next = 10'b0000001000;
        end
        10'b0000010000: begin // B3
            B3_next = 10'b0000000001;
            S_next = 10'b0000000001;
            S1_next = 10'b0000000001;
            Count_next = 10'b0000000010;
            Wait_next = 10'b0000010000;
        end
        10'b0001000000: begin // Count
            B3_next = 0;
            S_next = 0;
            S1_next = 0;
            Count_next = done_counting ? 10'b0001000000 : 10'b0000010000;
            Wait_next = done_counting ? 10'b1000000000 : 10'b0000010000;
        end
        10'b1000000000: begin // Wait
            B3_next = 0;
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = ack ? 10'b0000000001 : 10'b1000000000;
        end
        default: begin
            B3_next = 0;
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
    endcase
end

assign done = state == 10'b1000000000;
assign counting = state == 10'b0001000000;
assign shift_ena = state == 10'b0000001100;

endmodule
