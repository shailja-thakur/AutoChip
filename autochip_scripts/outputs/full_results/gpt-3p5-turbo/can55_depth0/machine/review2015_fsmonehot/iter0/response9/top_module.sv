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

    // Declare all internal signals

    reg B3_active;
    reg S_active;
    reg S1_active;
    reg Count_active;
    reg Wait_active;

    // Update internal signals based on current state

    always @*
    begin
        B3_active = (state == 4'b0011) ? 1'b1 : 1'b0;
        S_active = (state == 4'b0001 || state == 4'b0100 || state == 4'b0111) ? 1'b1 : 1'b0;
        S1_active = (state == 4'b0010) ? 1'b1 : 1'b0;
        Count_active = (state == 4'b1000 || state == 4'b1001 || state == 4'b1010 || state == 4'b1011) ? 1'b1 : 1'b0;
        Wait_active = (state == 4'b1100) ? 1'b1 : 1'b0;
    end

    // Update outputs based on conditions

    always @*
    begin
        B3_next = (S1_active == 1'b1) ? 1'b1 : 1'b0;
        S_next = ((S_active == 1'b1 && d == 1'b0) || (S1_active == 1'b1 && d == 1'b0) || (state == 4'b0110 && d == 1'b0) || (Wait_active == 1'b1 && ack == 1'b1)) ? 1'b1 : 1'b0;
        S1_next = (S_active == 1'b1 && d == 1'b1) ? 1'b1 : 1'b0;
        Count_next = (B3_active == 1'b1 || (Count_active == 1'b1 && done_counting == 1'b0)) ? 1'b1 : 1'b0;
        Wait_next = ((Count_active == 1'b1 && done_counting == 1'b1) || (Wait_active == 1'b1 && ack == 1'b0)) ? 1'b1 : 1'b0;
        done = (state == 4'b1100) ? 1'b1 : 1'b0;
        counting = (Count_active == 1'b1) ? 1'b1 : 1'b0;
        shift_ena = (B3_active == 1'b1 || Count_active == 1'b1) ? 1'b1 : 1'b0;
    end

endmodule
