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
    always @(state, d, ack, done_counting) begin
        case (state)
            S: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
                B3_next = 1'b0;
                S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1)) ? 1'b1 : 1'b0;
                S1_next = (state == S && d == 1) ? 1'b1 : 1'b0;
                Count_next = 1'b0;
                Wait_next = (state == Count && done_counting == 1) ? 1'b1 : 1'b0;
            end
            S1: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
                B3_next = (state == B2) ? 1'b1 : 1'b0;
                S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1)) ? 1'b1 : 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = (state == Count && done_counting == 1) ? 1'b1 : 1'b0;
            end
            S11: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
                B3_next = (state == B2) ? 1'b1 : 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = (state == Count && done_counting == 1) ? 1'b1 : 1'b0;
            end
            S110: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
                B3_next = (state == B2) ? 1'b1 : 1'b0;
                S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1)) ? 1'b1 : 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = (state == Count && done_counting == 1) ? 1'b1 : 1'b0;
            end
            B0: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
                B3_next = (state == B2) ? 1'b1 : 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = (state == Count && done_counting == 1) ? 1'b1 : 1'b0;
            end
            B1: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
                B3_next = (state == B2) ? 1'b1 : 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = (state == Count && done_counting == 1) ? 1'b1 : 1'b0;
            end
            B2: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = (state == Count && done_counting == 1) ? 1'b1 : 1'b0;
            end
            B3: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = (state == Count && done_counting == 1) ? 1'b1 : 1'b0;
            end
            Count: begin
                done = 1'b0;
                counting = 1'b1;
                shift_ena = 1'b0;
                B3_next = (state == B2) ? 1'b1 : 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = (done_counting == 0) ? 1'b1 : 1'b0;
                Wait_next = (state == Count && done_counting == 1) ? 1'b1 : 1'b0;
            end
            Wait: begin
                done = 1'b1;
                counting = 1'b0;
                shift_ena = 1'b0;
                B3_next = (state == B2) ? 1'b1 : 1'b0;
                S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1)) ? 1'b1 : 1'b0;
                S1_next = (state == S && d == 1) ? 1'b1 : 1'b0;
                Count_next = 1'b0;
                Wait_next = (state == Count && done_counting == 1) ? 1'b1 : 1'b0;
            end
        endcase
    end

 endmodule
