module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  reg [7:0] byte1, byte2, byte3;
  reg [1:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
    end else begin
      case (state)
        0: begin // Idle state, waiting for first byte with in[3] = 1
          if (in[3] == 1) begin
            byte1 <= in;
            state <= 1; // Transition to state 1
          end
        end
        1: begin // First byte received, waiting for second byte
          byte2 <= in;
          state <= 2; // Transition to state 2
        end
        2: begin // Second byte received, waiting for third byte
          byte3 <= in;
          state <= 3; // Transition to state 3
        end
        3: begin // Third byte received, message complete
          byte1 <= 0;
          byte2 <= 0;
          byte3 <= 0;
          state <= 0; // Transition back to idle state
        end
        default: begin
          state <= 0; // Default case, transition to idle state
        end
      endcase
    end
  end

  assign done = (state == 3);

endmodule
