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

 // Assign initial values to outputs
 always @*
 begin
   B3_next = 0;
   S_next = 0;
   S1_next = 0;
   Count_next = 0;
   Wait_next = 0;
   done = 0;
   counting = 0;
   shift_ena = 0;
 end

 // State transitions and output assignments
 always @(posedge clk)
 begin
   case(state)
     default:
       begin
         B3_next = 0;
         S_next = 0;
         S1_next = 0;
         Count_next = 0;
         Wait_next = 0;
       end

     // State S
     10'b0000000001:
       begin
         if(d == 0)
           S_next = 1;
         else
           S_next = 0;
       end

     // State S1
     10'b0000000010:
       begin
         if(d == 1)
           S1_next = 1;
         else
           S1_next = 0;
       end

     // State S11
     10'b0000000100:
       begin
         // No output assignment specified for state S11
       end

     // State S110
     10'b0000001000:
       begin
         if(d == 0)
           S_next = 1;
         else
           S_next = 0;
       end

     // State B0
     10'b0000010000:
       begin
         shift_ena = 1;
       end

     // State B1
     10'b0000100000:
       begin
         shift_ena = 1;
       end

     // State B2
     10'b0001000000:
       begin
         shift_ena = 1;
         B3_next = 1;
       end

     // State B3
     10'b0010000000:
       begin
         shift_ena = 1;
         B3_next = 1;
         Count_next = 1;
       end

     // State Count
     10'b0100000000:
       begin
         counting = 1;
         shift_ena = 1;
         if(done_counting == 0)
           Count_next = 1;
         else
           Wait_next = 1;
       end

     // State Wait
     10'b1000000000:
       begin
         shift_ena = 1;
         if(ack == 1)
           Wait_next = 1;
         else
           done = 1;
       end
   endcase
 end

endmodule
