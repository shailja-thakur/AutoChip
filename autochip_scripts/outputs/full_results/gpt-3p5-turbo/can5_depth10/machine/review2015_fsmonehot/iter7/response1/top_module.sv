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
    
    reg [9:0] next_state;
    
    always @(state, d, ack, done_counting) begin
        case (state)
            S: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
                B3_next = 1'b0;
                if (d == 0 && state != S110 && state != Wait)
                    S_next = 1'b1;
                else
                    S_next = 1'b0;
                if (d == 1 && state == S)
                    S1_next = 1'b1;
                else
                    S1_next = 1'b0;
                Count_next = 1'b0;
                if (state == Wait && ack == 1 && done_counting)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
            S1: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
                if (state == B2)
                    B3_next = 1'b1;
                else
                    B3_next = 1'b0;
                if (d == 0 && state != S110 && state != Wait)
                    S_next = 1'b1;
                else
                    S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                if (state == Wait && ack == 1 && done_counting)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
            S11: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
                if (state == B2)
                    B3_next = 1'b1;
                else
                    B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                if (state == Wait && ack == 1 && done_counting)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
            S110: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
                if (state == B2)
                    B3_next = 1'b1;
                else
                    B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                if (state == Wait && ack == 1 && done_counting)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
            B0: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
                if (state == B2)
                    B3_next = 1'b1;
                else
                    B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                if (state == Wait && ack == 1 && done_counting)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
            B1: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
                if (state == B2)
                    B3_next = 1'b1;
                else
                    B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                if (state == Wait && ack == 1 && done_counting)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
            B2: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                if (state == Wait && ack == 1 && done_counting)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
            B3: begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
                B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                if (state == Wait && ack == 1 && done_counting)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
            Count: begin
                done = 1'b0;
                counting = 1'b1;
                if (state == B3 || state == B2 || state == B1 || state == B0)
                    shift_ena = 1'b1;
                else
                    shift_ena = 1'b0;
                if (state == B2)
                    B3_next = 1'b1;
                else
                    B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                if (done_counting == 0)
                    Count_next = 1'b1;
                else
                    Count_next = 1'b0;
                if (state == Wait && ack == 1 && done_counting)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
            Wait: begin
                done = 1'b1;
                counting = 1'b0;
                if (state == B3 || state == B2 || state == B1 || state == B0)
                    shift_ena = 1'b1;
                else
                    shift_ena = 1'b0;
                if (state == B2)
                    B3_next = 1'b1;
                else
                    B3_next = 1'b0;
                if (d == 0 && state != S110 && state != Wait)
                    S_next = 1'b1;
                else
                    S_next = 1'b0;
                if (d == 1 && state == S)
                    S1_next = 1'b1;
                else
                    S1_next = 1'b0;
                Count_next = 1'b0;
                if (ack == 0)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end
    
    always @(state, S_next, S1_next, Count_next, Wait_next) begin
        next_state = state;
        case (state)
            S: begin
                if (S_next)
                    next_state = S;
                else if (S1_next)
                    next_state = S1;
                else if (Count_next)
                    next_state = Count;
                else if (Wait_next)
                    next_state = Wait;
            end
            S1: begin
                if (S_next)
                    next_state = S;
                else if (S1_next)
                    next_state = S1;
                else if (Count_next)
                    next_state = Count;
                else if (Wait_next)
                    next_state = Wait;
            end
            S11: begin
                if (S_next)
                    next_state = S;
                else if (S1_next)
                    next_state = S1;
                else if (Count_next)
                    next_state = Count;
                else if (Wait_next)
                    next_state = Wait;
            end
            S110: begin
                if (S_next)
                    next_state = S;
                else if (S1_next)
                    next_state = S1;
                else if (Count_next)
                    next_state = Count;
                else if (Wait_next)
                    next_state = Wait;
            end
            B0: begin
                if (S_next)
                    next_state = S;
                else if (S1_next)
                    next_state = S1;
                else if (Count_next)
                    next_state = Count;
                else if (Wait_next)
                    next_state = Wait;
            end
            B1: begin
                if (S_next)
                    next_state = S;
                else if (S1_next)
                    next_state = S1;
                else if (Count_next)
                    next_state = Count;
                else if (Wait_next)
                    next_state = Wait;
            end
            B2: begin
                if (S_next)
                    next_state = S;
                else if (S1_next)
                    next_state = S1;
                else if (Count_next)
                    next_state = Count;
                else if (Wait_next)
                    next_state = Wait;
            end
            B3: begin
                if (S_next)
                    next_state = S;
                else if (S1_next)
                    next_state = S1;
                else if (Count_next)
                    next_state = Count;
                else if (Wait_next)
                    next_state = Wait;
            end
            Count: begin
                if (S_next)
                    next_state = S;
                else if (S1_next)
                    next_state = S1;
                else if (Count_next)
                    next_state = Count;
                else if (Wait_next)
                    next_state = Wait;
            end
            Wait: begin
                if (S_next)
                    next_state = S;
                else if (S1_next)
                    next_state = S1;
                else if (Count_next)
                    next_state = Count;
                else if (Wait_next)
                    next_state = Wait;
            end
        endcase
    end

endmodule
