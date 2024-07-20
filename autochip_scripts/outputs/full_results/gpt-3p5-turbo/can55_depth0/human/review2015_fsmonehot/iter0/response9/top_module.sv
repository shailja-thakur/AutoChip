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
  
always @* begin
    // State transition logic
    case (state)
        10'b0000000001: begin  // S
            S_next = (d == 1) ? 1 : 0;
            S1_next = (d == 1) ? 1 : 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0000000010: begin  // S1
            S_next = (d == 0) ? 1 : 0;
            S1_next = (d == 1) ? 1 : 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0000000100: begin  // S11
            S_next = 0;
            S1_next = (d == 0) ? 1 : 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0000001000: begin  // S110
            S_next = 0;
            S1_next = 0;
            Count_next = (d == 1) ? 1 : 0;
            Wait_next = 0;
        end
        10'b0000000000: begin  // B0
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0000000000: begin  // B1
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0000000000: begin  // B2
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0000000000: begin  // B3
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0000000000: begin  // Count
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0000000000: begin  // Wait
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = (done == 1 && ack == 1) ? 1 : 0;
        end
    endcase
    
    // Output logic
    counting = (state == 10'b0000000000 || state == 10'b0000000000) ? 1 : 0;
    shift_ena = (state >= 10'b0000000010 && state <= 10'b0000001000) ? 1 : 0;
    done = 0;
    
    // Next state logic for B3
    B3_next = (shift_ena == 1) ? 1 : 0;
end

endmodule
