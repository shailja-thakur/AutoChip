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

    // Define the states as parameters
    parameter [9:0] S = 10'b0000000001;    // S state
    parameter [9:0] S1 = 10'b0000000010;   // S1 state
    parameter [9:0] S11 = 10'b0000000011;  // S11 state
    parameter [9:0] S110 = 10'b0000000100; // S110 state
    parameter [9:0] B0 = 10'b0000001000;   // B0 state
    parameter [9:0] B1 = 10'b0000010000;   // B1 state
    parameter [9:0] B2 = 10'b0000100000;   // B2 state
    parameter [9:0] B3 = 10'b0001000000;   // B3 state
    parameter [9:0] Count = 10'b0010000000;   // Count state
    parameter [9:0] Wait = 10'b0100000000;    // Wait state

    // Assign default values to the output signals
    always @* begin
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (state)
            S: begin
                if (d == 0)
                    S_next = 1'b1;
                else if (d == 1)
                    S1_next = 1'b1;
                else if (state == Wait && ack == 1)
                    Wait_next = 1'b1;
                else
                    done = 1'b1;
            end
            S1: begin
                if (state == B2)
                    B3_next = 1'b1;
                else if (d == 0 && state != S110 && state != Wait)
                    S_next = 1'b1;
            end
            S11: begin
                if (state == B2)
                    B3_next = 1'b1;
            end
            S110: begin
                if (state == B2)
                    B3_next = 1'b1;
            end
            B0: begin
                shift_ena = 1'b1;
                if (state == B2)
                    B3_next = 1'b1;
            end
            B1: begin
                shift_ena = 1'b1;
                if (state == B2)
                    B3_next = 1'b1;
            end
            B2: begin
                shift_ena = 1'b1;
            end
            B3: begin
                shift_ena = 1'b1;
            end
            Count: begin
                counting = 1'b1;
                shift_ena = 1'b1;
                B3_next = (state == B2) ? 1'b1 : 1'b0;
                if (state != B3 && done_counting == 0)
                    Count_next = 1'b1;
                else if (state == Wait && ack == 1)
                    Wait_next = 1'b1;
            end
            Wait: begin
                shift_ena = 1'b1;
                B3_next = (state == B2) ? 1'b1 : 1'b0;
                if (state == Wait && ack == 0)
                    Wait_next = 1'b1;
                else
                    done = 1'b1;
            end
        endcase
    end

endmodule
