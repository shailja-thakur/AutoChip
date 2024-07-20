module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);
    
  assign next_state = 10'b0000000000;
    
  always @* begin
    case (state)
      10'b0000000001: begin // S0
        out1 = 1'b0;
        out2 = 1'b0;
        if (in == 1'b0)
          next_state = 10'b0000000001; // S0
        else if (in == 1'b1)
          next_state = 10'b0000000010; // S1
      end
      
      10'b0000000010: begin // S1
        out1 = 1'b0;
        out2 = 1'b0;
        if (in == 1'b0)
          next_state = 10'b0000000001; // S0
        else if (in == 1'b1)
          next_state = 10'b0000000100; // S2
      end
      
      10'b0000000100: begin // S2
        out1 = 1'b0;
        out2 = 1'b0;
        if (in == 1'b0)
          next_state = 10'b0000000001; // S0
        else if (in == 1'b1)
          next_state = 10'b0000001000; // S3
      end
      
      10'b0000001000: begin // S3
        out1 = 1'b0;
        out2 = 1'b0;
        if (in == 1'b0)
          next_state = 10'b0000000001; // S0
        else if (in == 1'b1)
          next_state = 10'b0000010000; // S4
      end
      
      10'b0000010000: begin // S4
        out1 = 1'b0;
        out2 = 1'b0;
        if (in == 1'b0)
          next_state = 10'b0000000001; // S0
        else if (in == 1'b1)
          next_state = 10'b0000100000; // S5
      end
      
      10'b0000100000: begin // S5
        out1 = 1'b0;
        out2 = 1'b0;
        if (in == 1'b0)
          next_state = 10'b0001000000; // S8
        else if (in == 1'b1)
          next_state = 10'b0001000000; // S6
      end
      
      10'b0001000000: begin // S6
        out1 = 1'b0;
        out2 = 1'b0;
        if (in == 1'b0)
          next_state = 10'b0010000000; // S9
        else if (in == 1'b1)
          next_state = 10'b0010000000; // S7
      end
      
      10'b0010000000: begin // S7
        out1 = 1'b0;
        out2 = 1'b1;
        if (in == 1'b0)
          next_state = 10'b0000000001; // S0
        else if (in == 1'b1)
          next_state = 10'b0010000001; // S7
      end
      
      10'b0010000001: begin // S7
        out1 = 1'b0;
        out2 = 1'b1;
        if (in == 1'b0)
          next_state = 10'b0000000001; // S0
        else if (in == 1'b1)
          next_state = 10'b0010000001; // S7
      end
      
      10'b0001000001: begin // S8
        out1 = 1'b1;
        out2 = 1'b0;
        if (in == 1'b0)
          next_state = 10'b0000000001; // S0
        else if (in == 1'b1)
          next_state = 10'b0000000010; // S1
      end
      
      10'b0010000010: begin // S9
        out1 = 1'b1;
        out2 = 1'b1;
        if (in == 1'b0)
          next_state = 10'b0000000001; // S0
        else if (in == 1'b1)
          next_state = 10'b0000000010; // S1
      end
      
      default: begin
        out1 = 1'b0;
        out2 = 1'b0;
        next_state = 10'b0000000000;
      end
    endcase
  end
  
endmodule
