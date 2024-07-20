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

    // Assign next state signals
    always @(state, d, done_counting, ack)
    begin
        case(state)
            
            S: begin
                S_next = (d == 0);
                S1_next = (d == 1);
            end
            
            S1: begin
                S_next = (d == 0);
                S1_next = (d == 1);
            end
            
            S11: begin
                S_next = (d == 0);
                S1_next = (d == 1);
            end
            
            S110: begin
                S_next = (d == 0);
                S1_next = (d == 1);
            end
            
            B0: begin
                S_next = (d == 0);
                S1_next = (d == 1);
                
                shift_ena = 1;
            end
            
            B1: begin
                S_next = (d == 0);
                S1_next = (d == 1);
                
                shift_ena = 1;
            end
            
            B2: begin
                S_next = (d == 0);
                S1_next = (d == 1);
                
                shift_ena = 1;
                B3_next = 1;
            end
            
            B3: begin
                S_next = (d == 0);
                S1_next = (d == 1);
                
                shift_ena = 1;
            end
            
            Count: begin
                S_next = (d == 0);
                S1_next = (d == 1);
                
                Count_next = (~done_counting);
            end
            
            Wait: begin
                S_next = (d == 0);
                S1_next = (d == 1);
                
                Wait_next = (~ack);
            end
            
        endcase
    end
    
    // Assign done and counting signals
    always @(state)
    begin
        done = (state == Wait);
        counting = (state == Count);
    end

endmodule
