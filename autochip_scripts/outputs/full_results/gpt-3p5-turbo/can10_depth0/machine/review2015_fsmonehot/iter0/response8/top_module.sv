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
 
    reg [9:0] next_state;
    
    always @(state) begin
        case(state)
            S: begin
                if (d == 0)
                    S_next = 1;
                else
                    S_next = 0;
                S1_next = 0;
                next_state = S1;
            end
            S1: begin
                if (d == 1)
                    S1_next = 1;
                else
                    S1_next = 0;
                S_next = 0;
                next_state = S110;
            end
            S11: begin
                S_next = 0;
                S1_next = 0;
                next_state = S110;
            end
            S110: begin
                if (d == 0)
                    S_next = 1;
                else
                    S_next = 0;
                S1_next = 0;
                next_state = Wait;
            end
            B0: begin
                B3_next = 0;
                shift_ena = 1;
                next_state = B1;
            end
            B1: begin
                B3_next = 0;
                shift_ena = 1;
                next_state = B2;
            end
            B2: begin
                B3_next = 1;
                shift_ena = 1;
                next_state = B3;
            end
            B3: begin
                B3_next = 0;
                shift_ena = 1;
                next_state = Count;
            end
            Count: begin
                B3_next = 0;
                shift_ena = 1;
                if (done_counting == 0)
                    Count_next = 1;
                else
                    Count_next = 0;
                if (done_counting == 1)
                    Wait_next = 1;
                else
                    Wait_next = 0;
                next_state = Wait;
            end
            Wait: begin
                B3_next = 0;
                shift_ena = 0;
                Wait_next = 0;
                if (ack == 1)
                    done = 1;
                else
                    done = 0;
                if (done_counting == 1)
                    counting = 1;
                else
                    counting = 0;
                next_state = S;
            end
            default: next_state = S;
        endcase
    end
    
    always @(posedge clk) begin
        state <= next_state;
    end
    
endmodule
