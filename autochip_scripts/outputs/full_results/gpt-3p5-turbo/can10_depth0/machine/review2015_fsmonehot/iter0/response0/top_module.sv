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

    reg S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;

    always @(*) begin
        case(state)
            10'b0000000001: S = 1; S1 = 0; S11 = 0; S110 = 0; B0 = 0; B1 = 0; B2 = 0; B3 = 0; Count = 0; Wait = 0;
            10'b0000000010: S = 0; S1 = 1; S11 = 0; S110 = 0; B0 = 0; B1 = 0; B2 = 0; B3 = 0; Count = 0; Wait = 0;
            10'b0000001000: S = 0; S1 = 0; S11 = 1; S110 = 0; B0 = 0; B1 = 0; B2 = 0; B3 = 0; Count = 0; Wait = 0;
            10'b0000010000: S = 0; S1 = 0; S11 = 0; S110 = 1; B0 = 0; B1 = 0; B2 = 0; B3 = 0; Count = 0; Wait = 0;
            10'b0000100000: S = 0; S1 = 0; S11 = 0; S110 = 0; B0 = 1; B1 = 0; B2 = 0; B3 = 0; Count = 0; Wait = 0;
            10'b0001000000: S = 0; S1 = 0; S11 = 0; S110 = 0; B0 = 0; B1 = 1; B2 = 0; B3 = 0; Count = 0; Wait = 0;
            10'b0010000000: S = 0; S1 = 0; S11 = 0; S110 = 0; B0 = 0; B1 = 0; B2 = 1; B3 = 0; Count = 0; Wait = 0;
            10'b0100000000: S = 0; S1 = 0; S11 = 0; S110 = 0; B0 = 0; B1 = 0; B2 = 0; B3 = 1; Count = 0; Wait = 0;
            10'b1000000000: S = 0; S1 = 0; S11 = 0; S110 = 0; B0 = 0; B1 = 0; B2 = 0; B3 = 0; Count = 1; Wait = 0;
            10'b0000000100: S = 0; S1 = 0; S11 = 0; S110 = 0; B0 = 0; B1 = 0; B2 = 0; B3 = 0; Count = 0; Wait = 1;
            default: S = 0; S1 = 0; S11 = 0; S110 = 0; B0 = 0; B1 = 0; B2 = 0; B3 = 0; Count = 0; Wait = 0;
        endcase
    end

    assign B3_next = (state == 10'b0000010000) ? 1 : 0;
    assign S_next = ((state == 10'b0000000001) && (d == 0)) || ((state == 10'b0000000010) && (d == 0)) || ((state == 10'b0000001000) && (d == 0)) || ((state == 10'b0000000100) && (ack == 1)) ? 1 : 0;
    assign S1_next = ((state == 10'b0000000001) && (d == 1)) ? 1 : 0;
    assign Count_next = (state == 10'b0100000000) || ((state == 10'b1000000000) && (done_counting == 0)) ? 1 : 0;
    assign Wait_next = ((state == 10'b1000000000) && (done_counting == 1)) || ((state == 10'b0000000100) && (ack == 0)) ? 1 : 0;

    assign done = (state == 10'b0000000100) ? 1 : 0;
    assign counting = (state == 10'b0100000000) ? 1 : 0;
    assign shift_ena = (state == 10'b0000100000) || (state == 10'b0001000000) || (state == 10'b0010000000) || (state == 10'b0100000000) ? 1 : 0;

endmodule
