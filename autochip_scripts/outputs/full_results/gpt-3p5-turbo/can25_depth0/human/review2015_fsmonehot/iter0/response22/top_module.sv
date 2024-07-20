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

always @(state) begin
    case(state)
        // S
        10'b0000000001:
            begin
                if(d == 1)
                    S_next = 1;
                else
                    S_next = 10'b0000000001;
                
                S1_next = 10'b0000000001;
                Count_next = 10'b0000000001;
                Wait_next = 10'b0000000001;
            end
        
        // S1
        10'b0000000010:
            begin
                if(d == 0)
                    S_next = 10'b0000000001;
                else
                    S_next = 10'b0000000010;
                
                if(d == 1)
                    S1_next = 1;
                else
                    S1_next = 10'b0000000010;
                
                Count_next = 10'b0000000010;
                Wait_next = 10'b0000000010;
            end
            
        // S11
        10'b0000000100:
            begin
                if(d == 0)
                    S_next = 10'b0000000001;
                else
                    S_next = 10'b0000000100;
                
                if(d == 1)
                    S1_next = 1;
                else
                    S1_next = 10'b0000000100;
                
                Count_next = 10'b0000000100;
                Wait_next = 10'b0000000100;
            end
            
        // S110
        10'b0000001000:
            begin
                if(d == 0)
                    S_next = 10'b0000000001;
                else
                    S_next = 10'b0000001000;
                
                S1_next = 10'b0000001000;
                
                Count_next = 10'b0000001000;
                Wait_next = 10'b0000001000;
            end
            
        // B0
        10'b0000010000:
            begin
                if(d == 1)
                    S_next = 10'b0000001100;
                else
                    S_next = 10'b0000000001;
                
                S1_next = 10'b0000001100;
                
                Count_next = 10'b0000001100;
                Wait_next = 10'b0000001100;
            end
            
        // B1
        10'b0000100000:
            begin
                if(d == 1)
                    S_next = 10'b0000010100;
                else
                    S_next = 10'b0000001100;
                
                S1_next = 10'b0000010100;
                
                Count_next = 10'b0000010100;
                Wait_next = 10'b0000010100;
            end
            
        // B2
        10'b0001000000:
            begin
                if(d == 1)
                    S_next = 10'b0000100100;
                else
                    S_next = 10'b0000010100;
                
                S1_next = 10'b0000100100;
                B3_next = 1;
                
                Count_next = 10'b0000100100;
                Wait_next = 10'b0000100100;
            end
            
        // B3
        10'b0010000000:
            begin
                if(d == 1)
                    S_next = 10'b0001000100;
                else
                    S_next = 10'b0000100100;
                
                S1_next = 10'b0001000100;
                B3_next = 10'b0001000100;
                
                Count_next = 10'b0001000100;
                Wait_next = 10'b0001000100;
            end
            
        // Count
        10'b0100000000:
            begin
                if(done_counting == 0)
                    Count_next = 10'b0100000000;
                else
                    Count_next = 10'b0010000000;
                
                Wait_next = 10'b0100000000;
            end
            
        // Wait
        10'b1000000000:
            begin
                if(done_counting == 1)
                    Wait_next = 10'b0100000000;
                else
                    Wait_next = 10'b1000000000;
                
                S_next = 10'b1000000000;
                S1_next = 10'b1000000000;
                Count_next = 10'b1000000000;
            end
    endcase
end

always @(state) begin
    done = (state == 10'b1000000000);
    counting = (state >= 10'b0100000000);
    shift_ena = (state >= 10'b0000010000);
end

endmodule
