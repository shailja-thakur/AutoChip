module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);

  // Assigning default values to outputs
  assign out1 = 0;
  assign out2 = 0;

  // Define the output and next state values based on the given state machine specification
  always @(*)
  begin
    case (state)
      10'b0000000001: // S0, input 0
        begin
          next_state = 10'b0000000001;
          out1 = 0;
          out2 = 0;
        end
      10'b0000000010: // S0, input 1
        begin
          next_state = 10'b0000000100;
          out1 = 0;
          out2 = 0;
        end
      10'b0000000100: // S1, input 0
        begin
          next_state = 10'b0000000001;
          out1 = 0;
          out2 = 0;
        end
      10'b0000000110: // S1, input 1
        begin
          next_state = 10'b0000001000;
          out1 = 0;
          out2 = 0;
        end
      10'b0000001000: // S2, input 0
        begin
          next_state = 10'b0000000001;
          out1 = 0;
          out2 = 0;
        end
      10'b0000001010: // S2, input 1
        begin
          next_state = 10'b0000010000;
          out1 = 0;
          out2 = 0;
        end
      10'b0000001100: // S3, input 0
        begin
          next_state = 10'b0000000001;
          out1 = 0;
          out2 = 0;
        end
      10'b0000001110: // S3, input 1
        begin
          next_state = 10'b0000100000;
          out1 = 0;
          out2 = 0;
        end
      10'b0000010000: // S4, input 0
        begin
          next_state = 10'b0000000001;
          out1 = 0;
          out2 = 0;
        end
      10'b0000010010: // S4, input 1
        begin
          next_state = 10'b0001000000;
          out1 = 0;
          out2 = 0;
        end
      10'b0000010100: // S5, input 0
        begin
          next_state = 10'b0010000000;
          out1 = 0;
          out2 = 0;
        end
      10'b0000010110: // S5, input 1
        begin
          next_state = 10'b0000001010;
          out1 = 0;
          out2 = 0;
        end
      10'b0000001011: // S6, input 0
        begin
          next_state = 10'b0011000000;
          out1 = 0;
          out2 = 0;
        end
      10'b0000001101: // S6, input 1
        begin
          next_state = 10'b0100000000;
          out1 = 0;
          out2 = 0;
        end
      10'b0000011010: // S7, input 0
        begin
          next_state = 10'b0000000001;
          out1 = 0;
          out2 = 1;
        end
      10'b0000011101: // S7, input 1
        begin
          next_state = 10'b0100000000;
          out1 = 0;
          out2 = 1;
        end
      10'b0001000001: // S8, input 0
        begin
          next_state = 10'b0000000001;
          out1 = 1;
          out2 = 0;
        end
      10'b0001000010: // S8, input 1
        begin
          next_state = 10'b0000000100;
          out1 = 1;
          out2 = 0;
        end
      10'b0100000010: // S9, input 0
        begin
          next_state = 10'b0000000001;
          out1 = 1;
          out2 = 1;
        end
      10'b0100000100: // S9, input 1
        begin
          next_state = 10'b0000000100;
          out1 = 1;
          out2 = 1;
        end
      default: // Default case for any other states
        begin
          next_state = 10'b0000000001;
          out1 = 0;
          out2 = 0;
        end
    endcase
  end

endmodule
