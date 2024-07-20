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

    // State definitions
    parameter S = 10'b0000000001;
    parameter S1 = 10'b0000000010;
    parameter S11 = 10'b0000000100;
    parameter S110 = 10'b0000001000;
    parameter B0 = 10'b0000010000;
    parameter B1 = 10'b0000100000;
    parameter B2 = 10'b0001000000;
    parameter B3 = 10'b0010000000;
    parameter Count = 10'b0100000000;
    parameter Wait = 10'b1000000000;

    // Outputs initialization
    assign done = (state == Wait);
    assign counting = (state == Count);
    assign shift_ena = (state[B3] || state[B2] || state[B1] || state[B0]);
  
    always @* begin
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
                if (d == 1)
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
                if (state[B2])
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
                S_next = 0;
                S1_next = 0;
                Wait_next = 0;
                if (state[B3] || done_counting == 0)
                    Count_next = 1;
                else
                    Count_next = 0;
                B3_next = 0;
            end
            
            Wait: begin
                if (state[Count] && done_counting == 1)
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
    
endmodule
