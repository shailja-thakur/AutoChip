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

always @(state or d) begin
    case(state)
        S: begin
            if (d == 0)
                next_state = S_next ? S_next : state;
            else
                next_state = S1_next ? S1_next : state;
        end
        
        S1: begin
            if (d == 1)
                next_state = S1_next ? S1_next : state;
            else
                next_state = S_next ? S_next : state;
        end
        
        S11, S110: begin
            next_state = S_next ? S_next : state;
        end
        
        B0, B1, B2, B3: begin
            next_state = Count_next ? Count_next : state;
            B3_next = (state == B2);
            shift_ena = 1;
        end
        
        Count: begin
            next_state = done_counting ? Wait_next : state;
            counting = 1;
        end
        
        Wait: begin
            if (ack == 1)
                next_state = Wait_next ? Wait_next : state;
            else
                next_state = done_counting ? Count_next : state;
            done = 1;
        end
        
        default: next_state = state;
    endcase
end

always @(*) begin
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    done = 0;
    counting = 0;
    shift_ena = 0;
    
    case(next_state)
        B3: begin
            B3_next = 1;
            shift_ena = 1;
        end
        
        S: begin
            if (d == 0 || (state == S11 && d == 0))
                S_next = 1;
        end
        
        S1: begin
            if (state == S && d == 1)
                S1_next = 1;
        end
        
        Count: begin
            Count_next = 1;
            counting = 1;
        end
        
        Wait: begin
            Wait_next = 1;
            done = 1;
        end
    endcase
end

endmodule
