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
    
    always @(state, d, ack, done_counting) begin
        case (state)
            S: begin
                S_next = (d == 0);
                S1_next = (d == 1);
                Count_next = 1'b0;
                Wait_next = (ack == 1);
                B3_next = 1'b0;
                shift_ena = 1'b0;
            end
            S1: begin
                S_next = (d == 0);
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = (ack == 1);
                B3_next = 1'b0;
                shift_ena = 1'b0;
            end
            S11: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = (ack == 1);
                B3_next = 1'b0;
                shift_ena = 1'b0;
            end
            S110: begin
                S_next = (d == 0);
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = (ack == 1);
                B3_next = 1'b0;
                shift_ena = 1'b0;
            end
            B0: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                B3_next = 1'b0;
                shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);
            end
            B1: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                B3_next = 1'b0;
                shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);
            end
            B2: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                B3_next = (state == B2);
                shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);
            end
            B3: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = (state == B3 || state == Count) && (done_counting == 0);
                Wait_next = 1'b0;
                B3_next = 1'b0;
                shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);
            end
            Count: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = (state == B3 || state == Count) && (done_counting == 0);
                Wait_next = (done_counting == 1);
                B3_next = 1'b0;
                shift_ena = 1'b0;
            end
            Wait: begin
                S_next = (d == 0) && (ack == 1);
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = (done_counting == 1);
                B3_next = 1'b0;
                shift_ena = 1'b0;
            end
            default: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                B3_next = 1'b0;
                shift_ena = 1'b0;
            end
        endcase
    end

    // Assign default values to the output signals
    always @(state, d, ack, done_counting) begin
        done = (state == Wait) ? 1'b1 : 1'b0;
        counting = (state == Count) ? 1'b1 : 1'b0;
    end

 endmodule
