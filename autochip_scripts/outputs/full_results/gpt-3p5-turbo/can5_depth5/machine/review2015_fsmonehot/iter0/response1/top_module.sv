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

always @(*) begin
    case(state)
        S: begin
            if (d == 0)
                S_next = 1;
            else
                S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
        end
        
        S1: begin
            if (d == 0)
                S1_next = 1;
            else
                S1_next = 0;
            S_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
        end
        
        S11: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
        end
        
        S110: begin
            if (d == 0)
                S_next = 1;
            else
                S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
        end
        
        B0: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
        end
        
        B1: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
        end
        
        B2: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            if (state[B3])
                B3_next = 1;
            else
                B3_next = 0;
        end
        
        B3: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
        end
        
        Count: begin
            if (state[B3] || done_counting == 0)
                Count_next = 1;
            else
                Count_next = 0;
            S_next = 0;
            S1_next = 0;
            Wait_next = 0;
            B3_next = 0;
        end
        
        Wait: begin
            if (state[Count] && done_counting)
                Wait_next = 1;
            else
                Wait_next = 0;
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            B3_next = 0;
        end
    endcase
end

assign done = state[Wait];
assign counting = state[Count];
assign shift_ena = state[B3] || state[B2] || state[B1] || state[B0];

endmodule
