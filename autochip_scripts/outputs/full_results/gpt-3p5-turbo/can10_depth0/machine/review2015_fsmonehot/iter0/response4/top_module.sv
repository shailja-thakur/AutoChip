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
    
    // States
    parameter S = 0;
    parameter S1 = 1;
    parameter S11 = 2;
    parameter S110 = 3;
    parameter B0 = 4;
    parameter B1 = 5;
    parameter B2 = 6;
    parameter B3 = 7;
    parameter Count = 8;
    parameter Wait = 9;
    
    // Default assignments for outputs
    assign B3_next = 0;
    assign S_next = 0;
    assign S1_next = 0;
    assign Count_next = 0;
    assign Wait_next = 0;
    assign done = 0;
    assign counting = 0;
    assign shift_ena = 0;
    
    always @(*)
    begin
        case(state)
            S:
                begin
                    if(d == 0)
                        S_next = 1;
                end
                
            S1:
                begin
                    if(d == 0)
                        S1_next = 1;
                end
                
            S110:
                begin
                    if(d == 0)
                        S_next = 1;
                end
                
            Wait:
                begin
                    if(ack == 1)
                        Wait_next = 1;
                end
        endcase
        
        case(state)
            S1:
                begin
                    if(d == 1)
                        S1_next = 1;
                end
        endcase
        
        case(state)
            B3:
                begin
                    B3_next = 1;
                end
                
            Count:
                begin
                    if(done_counting == 0)
                        Count_next = 1;
                end
        endcase
        
        case(state)
            Count:
                begin
                    if(done_counting == 1)
                        Wait_next = 1;
                end
                
            Wait:
                begin
                    if(ack == 0)
                        Wait_next = 1;
                end
        endcase
        
        case(state)
            B3, B2, B1, B0:
                begin
                    shift_ena = 1;
                end
        endcase
        
        case(state)
            Wait:
                begin
                    done = 1;
                end
        endcase
        
        case(state)
            Count:
                begin
                    counting = 1;
                end
        endcase
    end
endmodule
