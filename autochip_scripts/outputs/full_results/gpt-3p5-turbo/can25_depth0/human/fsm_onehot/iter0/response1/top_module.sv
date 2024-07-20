module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);

  // Define the state transition logic
  always @(in or state) begin
    case (state)
      // State S0
      10'b0000000001: 
        begin
          if (in == 1'b0)
            next_state = 10'b0000000001;
          else
            next_state = 10'b0000000010;
        end
      
      // State S1
      10'b0000000010:
        begin
          if (in == 1'b0)
            next_state = 10'b0000000001;
          else
            next_state = 10'b0000000100;
        end

      // State S2
      10'b0000000100:
        begin
          if (in == 1'b0)
            next_state = 10'b0000000001;
          else
            next_state = 10'b0000001000;
        end

      // State S3
      10'b0000001000:
        begin
          if (in == 1'b0)
            next_state = 10'b0000000001;
          else
            next_state = 10'b0000010000;
        end

      // State S4
      10'b0000010000:
        begin
          if (in == 1'b0)
            next_state = 10'b0000000001;
          else
            next_state = 10'b0000100000;
        end

      // State S5
      10'b0000100000:
        begin
          if (in == 1'b0)
            next_state = 10'b0001000000;
          else
            next_state = 10'b0001000000;
        end

      // State S6
      10'b0001000000:
        begin
          if (in == 1'b0)
            next_state = 10'b0010000000;
          else
            next_state = 10'b0010000000;
        end

      // State S7
      10'b0010000000:
        begin
          if (in == 1'b0)
            next_state = 10'b0000000001;
          else
            next_state = 10'b0010000000;
        end

      // State S8
      10'b0100000000:
        begin
          if (in == 1'b0)
            next_state = 10'b0000000001;
          else
            next_state = 10'b0000000010;
        end

      // State S9
      10'b1000000000:
        begin
          if (in == 1'b0)
            next_state = 10'b0000000001;
          else
            next_state = 10'b0000000010;
        end
  
      default:
        next_state = 10'bxxxxxxxxxx;

    endcase
  end

  // Define the output logic
  always @(state) begin
    case (state)
      // State S7
      10'b0010000000:
        begin
          out1 = 1'b0;
          out2 = 1'b1;
        end

      // State S9
      10'b1000000000:
        begin
          out1 = 1'b1;
          out2 = 1'b1;
        end

      default:
        out1 = 1'b0;
        out2 = 1'b0;
    endcase
  end

endmodule
