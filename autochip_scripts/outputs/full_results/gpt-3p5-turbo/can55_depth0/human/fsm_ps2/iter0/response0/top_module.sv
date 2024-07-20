module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  
  reg [2:0] state;
  reg [7:0] byte1, byte2, byte3;
  reg done_next;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 0;
    else begin
      case (state)
        0: begin // Wait for first byte with in[3]=1
          if (in[3] == 1) begin
            state <= 1;
            byte1 <= in;
          end else
            state <= 0;
          end
        1: begin // Receive second byte
          state <= 2;
          byte2 <= in;
        end
        2: begin // Receive third byte
          state <= 3;
          byte3 <= in;
        end
        3: begin // Signal done, reset state and wait for next message
          state <= 0;
          byte1 <= 0;
          byte2 <= 0;
          byte3 <= 0;
        end
        default: state <= 0;
      endcase
    end
  end
  
  assign done = done_next;
  
  always @(state, byte1, byte2, byte3) begin
    done_next = (state == 3);
  end
  
endmodule
