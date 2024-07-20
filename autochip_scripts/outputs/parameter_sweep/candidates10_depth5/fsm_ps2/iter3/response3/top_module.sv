module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  
  reg [2:0] state;
  reg prev_in3;
  reg received_byte1, received_byte2;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      prev_in3 <= 0;
      received_byte1 <= 0;
      received_byte2 <= 0;
    end else begin
      prev_in3 <= in[3];
      
      case (state)
        0: begin  // Idle state
          if (in[3] == 1 && prev_in3 == 0) begin
            state <= 1;  // Transition to first byte state
          end else begin
            state <= 0;
          end
        end
        1: begin  // First byte state
          received_byte1 <= 1;
          state <= 2;  // Transition to second byte state
        end
        2: begin  // Second byte state
          received_byte2 <= 1;
          state <= 3;  // Transition to third byte state
        end
        3: begin  // Third byte state
          received_byte1 <= 0;
          received_byte2 <= 0;
          state <= 0;  // Transition back to idle state
        end
      endcase
    end
  end

  assign done = (received_byte1 && received_byte2);

endmodule
