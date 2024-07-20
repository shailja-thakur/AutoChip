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

    // State transition logic
    always @*
    begin
        case(state)
            // State S
            10'b0000000001: begin
                if (d == 1)
                    S_next = 10'b0000000010;  // Transition to state S1
                else
                    S_next = 10'b0000000001;  // Remain in state S
            end

            // State S1
            10'b0000000010: begin
                if (d == 1)
                    S1_next = 10'b0000000100;  // Transition to state S11
                else
                    S1_next = 10'b0000000001;  // Transition to state S
            end

            // State S11
            10'b0000000100: begin
                if (d == 1)
                    S11_next = 10'b0000000100;  // Remain in state S11
                else
                    S11_next = 10'b0000001000;  // Transition to state S110
            end

            // State S110
            10'b0000001000: begin
                if (d == 1)
                    S110_next = 10'b0000000010;  // Transition to state S1
                else
                    S110_next = 10'b1000000000;  // Transition to state B0
            end

            // State B0
            10'b1000000000: B0_next = 10'b0100000000;  // Transition to state B1

            // State B1
            10'b0100000000: B1_next = 10'b0010000000;  // Transition to state B2

            // State B2
            10'b0010000000: B2_next = 10'b0001000000;  // Transition to state B3

            // State B3
            10'b0001000000: B3_next = 10'b1000000000;  // Transition to state Count

            // State Count
            10'b0000000010: begin
                if (done_counting)
                    Count_next = 10'b1000000000;  // Transition to state Wait
                else
                    Count_next = 10'b0000000010;  // Remain in state Count
            end

            // State Wait
            10'b1000000000: begin
                if (ack == 1)
                    Wait_next = 10'b0000000001;  // Transition to state S
                else
                    Wait_next = 10'b1000000000;  // Remain in state Wait
            end
        endcase
    end

    // Output logic
    assign done = ((state == 10'b1000000000) ? 1'b1 : 1'b0);
    assign counting = ((state == 10'b0000000010 || state == 10'b1000000000) ? 1'b1 : 1'b0);
    assign shift_ena = ((state >= 10'b1000000000 && state <= 10'b0001000000) ? 1'b1 : 1'b0);

endmodule
