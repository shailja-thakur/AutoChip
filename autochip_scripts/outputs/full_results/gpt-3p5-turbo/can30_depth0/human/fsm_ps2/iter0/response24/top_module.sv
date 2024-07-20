module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  reg [7:0] byte1; // first byte of the message
  reg [7:0] byte2; // second byte of the message
  reg [7:0] byte3; // third byte of the message
  reg [2:0] state; // state variable

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0; // reset the state
      done <= 0; // clear the done signal
    end else begin
      case(state)
        0: begin // waiting for byte 1
          if (in[3] == 1) begin
            byte1 <= in;
            state <= 1; // move to the next state
          end
        end
        1: begin // waiting for byte 2
          byte2 <= in;
          state <= 2; // move to the next state
        end
        2: begin // waiting for byte 3
          byte3 <= in;
          state <= 0; // reset the state
          done <= 1; // signal the receipt of a message
        end
      endcase
    end
  end
endmodule
