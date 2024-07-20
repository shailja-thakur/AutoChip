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
    done = (state == 10'bWait);
    counting = (state == 10'bCount);
    shift_ena = (state[3:0] != 4'b0000);
    
    case (state)
        10'bS: begin
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = ((d == 1'b0) || (state == 10'bS1) || (state == 10'bS110) || ((state == 10'bWait) && (ack == 1'b1)));
        end
        10'bS1: begin
            S_next = (d == 1'b0);
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = ((d == 1'b0) || (state == 10'bS) || (state == 10'bS110) || ((state == 10'bWait) && (ack == 1'b1)));
        end
        10'bS110: begin
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = ((d == 1'b0) || (state == 10'bS) || (state == 10'bS1) || ((state == 10'bWait) && (ack == 1'b1)));
        end
        10'bB0: begin
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = ((d == 1'b0) || (state == 10'bS) || (state == 10'bS1) || (state == 10'bS110));
        end
        10'bB1: begin
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = ((d == 1'b0) || (state == 10'bS) || (state == 10'bS1) || (state == 10'bS110));
        end
        10'bB2: begin
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            B3_next = 1'b1;
            Count_next = 1'b0;
            Wait_next = ((d == 1'b0) || (state == 10'bS) || (state == 10'bS1) || (state == 10'bS110));
        end
        10'bB3: begin
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            B3_next = 1'b0;
            Count_next = ((state == 10'bB3) || (state == 10'bCount) || (state == 10'bWait));
            Wait_next = ((d == 1'b0) || (state == 10'bS) || (state == 10'bS1) || (state == 10'bS110));
        end
        10'bCount: begin
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            B3_next = 1'b0;
            Count_next = ((state == 10'bB3) || (done_counting == 1'b0));
            Wait_next = ((d == 1'b0) || (state == 10'bS) || (state == 10'bS1) || (state == 10'bS110));
        end
        10'bWait: begin
            S_next = (d == 1'b0);
            S1_next = (d == 1'b1);
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = ((done_counting == 1'b1) || (ack == 1'b0));
        end
    endcase
  end
endmodule
