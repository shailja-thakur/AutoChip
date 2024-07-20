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
    // states
    parameter S = 10'd0;
    parameter S1 = 10'd1;
    parameter S11 = 10'd2;
    parameter S110 = 10'd3;
    parameter B0 = 10'd4;
    parameter B1 = 10'd5;
    parameter B2 = 10'd6;
    parameter B3 = 10'd7;
    parameter Count = 10'd8;
    parameter Wait = 10'd9;
    
    // nextState
    reg [9:0] nextState;
    
    always @(*) begin
        case(state)
            S: begin
                if (d == 0)
                    nextState = S_next ? S1 : S11;
                else
                    nextState = S;
            end
            
            S1: begin
                if (d == 1)
                    nextState = S1_next ? S1 : S110;
                else
                    nextState = S;
            end
            
            S11: begin
                nextState = S110;
            end
            
            S110: begin
                if (d == 0)
                    nextState = S_next ? S1 : S11;
                else
                    nextState = S;
            end
            
            B0: begin
                nextState = B1;
            end
            
            B1: begin
                nextState = B2;
            end
            
            B2: begin
                nextState = B3;
            end
            
            B3: begin
                if (state == B2)
                    B3_next = 1;
                nextState = B0;
            end
            
            Count: begin
                if (done_counting == 0 || state == B3)
                    Count_next = 1;
                nextState = Wait;
            end
            
            Wait: begin
                if (ack == 0 || state == Count)
                    Wait_next = 1;
                nextState = Wait;
            end
        endcase
    end
    
    always @(posedge clk) begin
        state <= nextState;
        
        done = (state == Wait);
        counting = (state == Count);
        shift_ena = (state == B0 || state == B1 || state == B2 || state == B3);
        
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
    end
endmodule
