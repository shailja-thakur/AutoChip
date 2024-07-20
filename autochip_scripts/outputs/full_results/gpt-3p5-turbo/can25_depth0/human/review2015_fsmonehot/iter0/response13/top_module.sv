module top_module(
  input d,
  input done_counting,
  input ack,
  input [9:0] state,
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
      // State S
      10'b0000000001: begin
        if (d == 1)
          S1_next = 1;
        else
          S_next = 1;
      end
      
      // State S1
      10'b0000000010: begin
        if (d == 1)
          S11_next = 1;
        else
          S_next = 1;
      end
      
      // State S11
      10'b0000000100: begin
        if (d == 1)
          S11_next = 1;
        else
          S110_next = 1;
      end
      
      // State S110
      10'b0000001000: begin
        if (d == 1)
          B0_next = 1;
        else
          S_next = 1;
      end
      
      // State B0
      10'b0000010000: begin
        B1_next = 1;
        shift_ena = 1;
      end
      
      // State B1
      10'b0000100000: begin
        B2_next = 1;
        shift_ena = 1;
      end
      
      // State B2
      10'b0001000000: begin
        B3_next = 1;
        shift_ena = 1;
      end
      
      // State B3
      10'b0010000000: begin
        Count_next = 1;
        shift_ena = 1;
      end
      
      // State Count
      10'b0100000000: begin
        Count_next = 1;
        counting = 1;
      end
      
      // State Wait
      10'b1000000000: begin
        if (done == 1)
          if (ack == 1)
            S_next = 1;
          else
            Wait_next = 1;
      end
    endcase
  end
  
  always @(*) begin
    case (state)
      
      // State B3
      10'b0010000000: begin
        done = 0;
      end
      
      // State Count
      10'b0100000000: begin
        done = !done_counting;
      end
      
      // State Wait
      10'b1000000000: begin
        done = 1;
      end
      
      default: begin
        done = 0;
      end
      
    endcase
  end
  
endmodule
