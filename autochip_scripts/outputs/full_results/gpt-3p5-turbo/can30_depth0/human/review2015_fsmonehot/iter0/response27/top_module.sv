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

// Next-state logic
always @(*)
begin
    case(state)
        10'b0000000001:  // S
            begin
                if(d == 1'b0)
                    S_next = 1'b1;
                else if(d == 1'b1)
                    S_next = 1'b0;
            end
        
        10'b0000000010:  // S1
            begin
                if(d == 1'b0)
                    S1_next = 1'b0;
                else if(d == 1'b1)
                    S1_next = 1'b1;
            end
        
        10'b0000000100:  // S11
            begin
                if(d == 1'b0)
                    S11_next = 10'b001;
                else if(d == 1'b1)
                    S11_next = 10'b000;
            end
        
        10'b0000000011:  // S11
            begin
                if(d == 1'b0)
                    S110_next = 10'b0010;
                else if(d == 1'b1)
                    S110_next = 10'b0000;
            end
        
        10'b0000000101,  // B0
        10'b0000000110,  // B1
        10'b0000000111:  // B2
            B3_next = 1'b1;
        
        10'b0000001000:  // B3
            B3_next = 1'b1;
        
        10'b0000001001:  // Count
            begin
                if(done_counting == 1'b0)
                    Count_next = 1'b1;
                else if(done_counting == 1'b1)
                    Count_next = 1'b0;
            end
        
        10'b0000001010:  // Wait
            begin
                if(ack == 1'b0)
                    Wait_next = 1'b1;
                else if(ack == 1'b1)
                    Wait_next = 1'b0;
            end
    endcase
end

// Output logic
always @(*)
begin
    case(state)
        10'b0000001001,  // Count
        10'b0000000111,  // B2
        10'b0000001000:  // B3
            counting = 1'b1;
        
        default:
            counting = 1'b0;
    endcase
    
    case(state)
        10'b0000000011,  // S11
        10'b0000001001,  // Count
        10'b0000001010:  // Wait
            done = 1'b1;
        
        default:
            done = 1'b0;
    endcase
    
    case(state)
        10'b0000000101,  // B0
        10'b0000000110,  // B1
        10'b0000000111,  // B2
        10'b0000001000:  // B3
            shift_ena = 1'b1;
        
        default:
            shift_ena = 1'b0;
    endcase
end

endmodule
