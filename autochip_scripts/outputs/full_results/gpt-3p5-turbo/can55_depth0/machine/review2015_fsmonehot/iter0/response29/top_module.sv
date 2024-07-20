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

    // Assign the default values for the outputs
    assign done = (state == 10'b010);
    assign counting = (state == 10'b100);
    assign shift_ena = (state[3] | state[4] | state[5] | state[6]);

    // Next state logic
    always @*
    begin
        B3_next = (state == 10'b101);
        S_next = ((state == 10'b001) && (d == 0)) || ((state == 10'b011) && (d == 0)) || ((state == 10'b110) && (d == 0)) || ((state == 10'b010) && (ack == 1));
        S1_next = ((state == 10'b001) && (d == 1));
        Count_next = ((state == 10'b101) || ((state == 10'b100) && (done_counting == 0)));
        Wait_next = ((state == 10'b100) && (done_counting == 1)) || ((state == 10'b010) && (ack == 0));
    end
endmodule
