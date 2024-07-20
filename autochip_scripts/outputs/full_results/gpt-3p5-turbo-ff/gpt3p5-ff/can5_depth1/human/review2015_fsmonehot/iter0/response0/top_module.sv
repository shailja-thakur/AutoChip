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
        case (state)
            10'b0000000001: begin // S
                S_next = d ? 10'b0000000010 : 10'b0000000001;
                S1_next = d ? 10'b0000000010 : 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            10'b0000000010: begin // S1
                S_next = 0;
                S1_next = d ? 10'b0000000100 : 10'b0000000010;
                Count_next = 0;
                Wait_next = 0;
            end
            
            10'b0000000100: begin // S11
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            10'b0000001000: begin // S110
                S_next = 10'b0000000001;
                S1_next = 10'b0000000010;
                Count_next = 0;
                Wait_next = 0;
            end
            
            10'b0000010000: begin // B0
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            10'b0000100000: begin // B1
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            10'b0001000000: begin // B2
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            
            10'b0010000000: begin // B3
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
                B3_next = 1;
            end
            
            10'b0100000000: begin // Count
                S_next = 0;
                S1_next = 0;
                Count_next = done_counting ? 10'b0010000000 : 10'b0100000000;
                Wait_next = done_counting ? 10'b1000000000 : 0;
            end
            
            10'b1000000000: begin // Wait
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = ack ? 10'b0000000001 : 10'b1000000000;
            end
        endcase
    end
    
    always @(*) begin
        shift_ena = (state == 10'b0000010000 || state == 10'b0000100000 || state == 10'b0001000000 || state == 10'b0010000000 || state == 10'b0100000000 || state == 10'b1000000000);
        counting = (state == 10'b0100000000);
        done = (state == 10'b1000000000);
    end
    
endmodule
