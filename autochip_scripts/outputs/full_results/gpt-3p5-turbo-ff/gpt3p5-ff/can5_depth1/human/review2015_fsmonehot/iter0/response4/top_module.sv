module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );
    
    // State transition logic
    always @* begin
        case(state)
            // State S transitions
            10'b0000000001: begin
                if(d == 1'b0)
                    S_next = 1'b1;
                else
                    S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            
            // State S1 transitions
            10'b0000000010: begin
                if(d == 1'b0)
                    S_next = 1'b1;
                else
                    S_next = 1'b0;
                if(d == 1'b1)
                    S1_next = 1'b1;
                else
                    S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            
            // State S11 transitions
            10'b0000000100: begin
                if(d == 1'b0)
                    S_next = 1'b1;
                else
                    S_next = 1'b0;
                if(d == 1'b1)
                    S1_next = 1'b1;
                else
                    S1_next = 1'b0;
                if(d == 1'b1)
                    Count_next = 1'b1;
                else
                    Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            
            // State S110 transitions
            10'b0000001000: begin
                if(d == 1'b0)
                    S_next = 1'b1;
                else
                    S_next = 1'b0;
                if(d == 1'b1)
                    S1_next = 1'b1;
                else
                    S1_next = 1'b0;
                if(d == 1'b1)
                    Count_next = 1'b1;
                else
                    Count_next = 1'b0;
                Wait_next = 1'b0;
            end
            
            // State B0 transitions
            10'b0000010000: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                if(ack == 1'b1)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
            
            // State B1 transitions
            10'b0000100000: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                if(ack == 1'b1)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
            
            // State B2 transitions
            10'b0001000000: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                if(ack == 1'b1)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
            end
            
            // State B3 transitions
            10'b0010000000: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                if(ack == 1'b1)
                    Wait_next = 1'b1;
                else
                    Wait_next = 1'b0;
                B3_next = 1'b0;
                if(shift_ena == 1'b1)
                    B3_next = 1'b1;
            end
            
            // State Count transitions
            10'b0100000000: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                B3_next = 1'b0;
                Wait_next = 1'b0;
                if(done_counting == 1'b0)
                    Count_next = 1'b1;
                else
                    Count_next = 1'b0;
            end
            
            // State Wait transitions
            10'b1000000000: begin
                S_next = 1'b1;
                S1_next = 1'b0;
                B3_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                if(done == 1'b1)
                    Wait_next = 1'b1;
            end
        endcase
    end
    
    // Output logic
    always @* begin
        case(state)
            // State B3 output
            10'b0010000000:
                if(shift_ena == 1'b1)
                    B3_next = 1'b1;
                else
                    B3_next = 1'b0;
                
            // State S output
            10'b0000000001:
                S_next = 1'b0;
            
            // State S1 output
            10'b0000000010:
                S1_next = 1'b0;
            
            // State Count output
            10'b0100000000:
                Count_next = 1'b1;
            
            // State Wait output
            10'b1000000000:
                Wait_next = 1'b0;
            
            // Done output
            default:
                done = 1'b0;
        endcase
    end
    
    // Assign outputs
    assign counting = Count_next;
    assign shift_ena = B3_next;
    
endmodule
