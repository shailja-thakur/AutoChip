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

    // Assign initial values for outputs
    assign done = (state == 4'b1010); // Wait state
    assign counting = (state == 4'b1001) || (state == 4'b0110) || (state == 4'b0010) || (state == 4'b0001); // B3, B2, B1, B0 states

    // Combinational logic for shift_ena
    always @*
    begin
        shift_ena = (state == 4'b1001) || (state == 4'b0110) || (state == 4'b0010) || (state == 4'b0001); // B3, B2, B1, B0 states
    end

    // Combinational logic for B3_next
    always @*
    begin
        B3_next = (state == 4'b0110); // B2 state
    end

    // Combinational logic for S_next
    always @*
    begin
        S_next = ((state == 4'b0000) && (d == 0)) || ((state == 4'b0001) && (d == 0)) || ((state == 4'b0110) && (d == 0)) || ((state == 4'b1010) && (ack == 1)); // S, S1, S110, Wait states
    end

    // Combinational logic for S1_next
    always @*
    begin
        S1_next = ((state == 4'b0000) && (d == 1)); // S state
    end

    // Combinational logic for Count_next
    always @*
    begin
        Count_next = (state == 4'b0110) || ((state == 4'b1001) && (done_counting == 0)); // B3 state, Count state with done_counting = 0
    end

    // Combinational logic for Wait_next
    always @*
    begin
        Wait_next = ((state == 4'b1001) && (done_counting == 1)) || ((state == 4'b1010) && (ack == 0)); // Count state with done_counting = 1, Wait state with ack = 0
    end

endmodule
