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
    case (state)
        // current state is S
        10'h0: begin
            S_next = (d == 0);
            S1_next = 0;
            Count_next = 0;
            Wait_next = (ack == 1);
            B3_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        
        // current state is S1
        10'h1: begin
            S_next = 0;
            S1_next = (d == 1);
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        
        // current state is S11
        10'h2: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        
        // current state is S110
        10'h3: begin
            S_next = (d == 0);
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        
        // current state is B0
        10'h4: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 1;
        end
        
        // current state is B1
        10'h5: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 1;
        end
        
        // current state is B2
        10'h6: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 1;
            done = 0;
            counting = 0;
            shift_ena = 1;
        end
        
        // current state is B3
        10'h7: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 1;
            Wait_next = 0;
            B3_next = 0;
            done = 0;
            counting = 1;
            shift_ena = 1;
        end
        
        // current state is Count
        10'h8: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = (done_counting == 1);
            B3_next = 0;
            done = 0;
            counting = 1;
            shift_ena = 0;
        end
        
        // current state is Wait
        10'h9: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 0;
            done = 1;
            counting = 0;
            shift_ena = 0;
        end
    endcase
end

endmodule
