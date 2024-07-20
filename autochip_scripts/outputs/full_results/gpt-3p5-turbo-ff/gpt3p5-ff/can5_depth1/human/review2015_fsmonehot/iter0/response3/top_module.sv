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
        10'b0000000000: begin
            S_next = (d) ? 1 : 0;
            S1_next = (d) ? 1 : 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        10'b0000000001: begin
            S_next = (d) ? 1 : 0;
            S1_next = (d) ? 1 : 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        10'b0000000010: begin
            S_next = 0;
            S1_next = (d) ? 1 : 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        10'b0000000100: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        // ... fill in the remaining cases ...
        
    endcase
end

always @(*) begin
    case (state)
        10'b0000000000: begin
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        
        10'b0000000001: begin
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        
        10'b0000000010: begin
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        
        10'b0000000100: begin
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        
        // ... fill in the remaining cases ...
        
    endcase
end

endmodule
