module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

  reg [2:0] state;
  reg [7:0] buffer [0:2];
  reg start_flag;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      start_flag <= 0;
      done <= 0;
      buffer[0] <= 0;
      buffer[1] <= 0;
      buffer[2] <= 0;
    end else begin
      case (state)
        0: begin // Wait for start of new message
          if (in[3]) begin
            state <= 1;
            buffer[0] <= in;
          end
        end
        1: begin // Receive second byte of message
          buffer[1] <= in;
          state <= 2;
        end
        2: begin // Receive third byte of message
          buffer[2] <= in;
          done <= 1; // Signal the receipt of a message
          state <= 0;
        end
      endcase
    end
  end

endmodule
