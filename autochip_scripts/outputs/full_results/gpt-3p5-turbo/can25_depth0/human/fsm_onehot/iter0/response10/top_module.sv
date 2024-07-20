module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Combinational logic for state transition
    always @* begin
        case(state)
            // State S0
            10'b1_0000_0000 : begin
                if (in)
                    next_state = 10'b0_0000_0010; // Transition to S1 if input is 1
                else
                    next_state = 10'b1_0000_0000; // Remain in S0
            end
            // State S1
            10'b0_0000_0010 : begin
                if (in)
                    next_state = 10'b0_0000_0100; // Transition to S2 if input is 1
                else
                    next_state = 10'b1_0000_0000; // Transition to S0 if input is 0
            end
            // State S2
            10'b0_0000_0100 : begin
                if (in)
                    next_state = 10'b0_0000_1000; // Transition to S3 if input is 1
                else
                    next_state = 10'b1_0000_0000; // Transition to S0 if input is 0
            end
            // State S3
            10'b0_0000_1000 : begin
                if (in)
                    next_state = 10'b0_0001_0000; // Transition to S4 if input is 1
                else
                    next_state = 10'b1_0000_0000; // Transition to S0 if input is 0
            end
            // State S4
            10'b0_0001_0000 : begin
                if (in)
                    next_state = 10'b0_0010_0000; // Transition to S5 if input is 1
                else
                    next_state = 10'b1_0000_0000; // Transition to S0 if input is 0
            end
            // State S5
            10'b0_0010_0000 : begin
                if (in)
                    next_state = 10'b1_0000_0000; // Transition to S8 if input is 0
                else
                    next_state = 10'b0_0100_0000; // Transition to S6 if input is 1
            end
            // State S6
            10'b0_0100_0000 : begin
                if (in)
                    next_state = 10'b1_0001_0000; // Transition to S9 if input is 0
                else
                    next_state = 10'b0_1000_0000; // Transition to S7 if input is 1
            end
            // State S7
            10'b0_1000_0000 : begin
                if (in)
                    next_state = 10'b1_0000_0000; // Transition to S0 if input is 0
                else
                    next_state = 10'b0_1000_0000; // Remain in S7
            end
            // State S8
            10'b0_0100_0000 : begin
                if (in)
                    next_state = 10'b0_0000_0010; // Transition to S1 if input is 1
                else
                    next_state = 10'b1_0000_0000; // Transition to S0 if input is 0
            end
            // State S9
            10'b0_1000_0000 : begin
                if (in)
                    next_state = 10'b0_0000_0010; // Transition to S1 if input is 1
                else
                    next_state = 10'b1_0000_0000; // Transition to S0 if input is 0
            end
            default: next_state = 10'b1_0000_0000; // Default state is S0
        endcase
    end

    // Combinational logic for outputs
    assign out1 = (state[7] || state[8]); // Output is 1 if state is S7 or S8
    assign out2 = state[6]; // Output is state[6]

endmodule
