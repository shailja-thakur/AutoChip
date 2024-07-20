module top_module(
    input wire d,
    input wire done_counting,
    input wire ack,
    input wire [9:0] state, // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
);
   
   always @(state or d or done_counting or ack) begin
      case (state)
         S: begin
            S_next = (d == 0) ? 1'b1 : 1'b0;
            S1_next = (d == 1) ? 1'b1 : 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
         end
         S1: begin
            S_next = (d == 0) ? 1'b1 : 1'b0;
            S1_next = (d == 1) ? 1'b1 : 1'b0;
            B3_next = 1'b0;
            Count_next = 0;
            Wait_next = 1'b0;
         end
         S11: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
         end
         S110: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
         end
         B0: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
         end
         B1: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
         end
         B2: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = (state == B2) ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
         end
         B3: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = (state == B3) ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
         end
         Count: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = (state == B3 || (state == Count && done_counting == 0)) ? 1'b1 : 1'b0;
            Wait_next = 1'b0;
         end
         Wait: begin
            S_next = (state == S && d == 0) ? 1'b1 : 1'b0;
            S1_next = (state == S && d == 1) ? 1'b1 : 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = (state == Count && done_counting == 1'b1) || (state == Wait && ack == 0) ? 1'b1 : 1'b0;
         end
         default: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
         end
      endcase
   end

   assign shift_ena = (state == B3 || state == B2 || state == B1 || state == B0) ? 1'b1 : 1'b0;
   assign done = (state == Wait) ? 1'b1 : 1'b0;
   assign counting = (state == Count) ? 1'b1 : 1'b0;

endmodule
