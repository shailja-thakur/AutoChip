module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 ); 

    // Define the next state variables
    reg B3_next, S_next, S1_next, Count_next, Wait_next;

    // Define the output variables
    wire done, counting, shift_ena;

    // Next state logic
    always @*
    begin
        case(state)
            // B3_next logic
            10'b1000000000: B3_next = 1'b1;
            default: B3_next = 1'b0;
        endcase

        // S_next logic
        if(d == 1'b1)
            S_next = 1'b1;
        else
            S_next = 1'b0;

        // S1_next logic
        if(state[0] == 1'b1 && d == 1'b1)
            S1_next = 1'b1;
        else
            S1_next = 1'b0;

        // Count_next logic
        if(state[0:2] == 3'b001 && d == 1'b1)
            Count_next = 1'b1;
        else
            Count_next = 1'b0;

        // Wait_next logic
        if(state[0:2] == 3'b001 && d == 1'b0)
            Wait_next = 1'b1;
        else
            Wait_next = 1'b0;
    end

    // Output logic
    assign done = (state == 10'b0000001011 && ack == 1'b1) ? 1'b1 : 1'b0;
    assign counting = (state[3:9] != 7'b0000000) ? 1'b1 : 1'b0;
    assign shift_ena = (state[3:9] == 7'b0001000) ? 1'b1 : 1'b0;

endmodule
