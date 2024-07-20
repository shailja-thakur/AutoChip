module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
  );

  always @(*) begin
    // Default values
    next_state = 10'b0000000000;
    out1 = 1'b0;
    out2 = 1'b0;
    
    case (state)
      10'b0000000001: begin // S0
        if (in)
          next_state = 10'b0000000010; // Go to S1
        else
          next_state = 10'b0000000001; // Stay in S0
      end
      10'b0000000010: begin // S1
        if (in)
          next_state = 10'b0000000100; // Go to S2
        else
          next_state = 10'b0000000001; // Go to S0
      end
      10'b0000000100: begin // S2
        if (in)
          next_state = 10'b0000001000; // Go to S3
        else
          next_state = 10'b0000000001; // Go to S0
      end
      10'b0000001000: begin // S3
        if (in)
          next_state = 10'b0000010000; // Go to S4
        else
          next_state = 10'b0000000001; // Go to S0
      end
      10'b0000010000: begin // S4
        if (in)
          next_state = 10'b0000100000; // Go to S5
        else
          next_state = 10'b0000000001; // Go to S0
      end
      10'b0000100000: begin // S5
        if (in)
          next_state = 10'b0001000000; // Go to S6
        else
          next_state = 10'b1000000000; // Go to S8
      end
      10'b0001000000: begin // S6
        if (in)
          next_state = 10'b0010000000; // Go to S7
        else
          next_state = 10'b0100000000; // Go to S9
      end
      10'b0010000000: begin // S7
        if (in)
          next_state = 10'b0010000000; // Stay in S7
        else
          next_state = 10'b0000000001; // Go to S0
        out2 = 1'b1; // Output from S7
      end
      10'b0100000000: begin // S8
        if (in)
          next_state = 10'b0000000010; // Go to S1
        else
          next_state = 10'b0000000001; // Go to S0
        out1 = 1'b1; // Output from S8
      end
      10'b1000000000: begin // S9
        if (in)
          next_state = 10'b0000000010; // Go to S1
        else
          next_state = 10'b0000000001; // Go to S0
        out1 = 1'b1; // Output from S9
        out2 = 1'b1; // Output from S9
      end
      default: begin
        next_state = 10'b0000000001; // Default to S0
      end
    endcase
  end

endmodule
