module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  reg [2:0] state;
  reg [7:0] buffer [0:2];
  reg [7:0] first_byte;
  reg done;

  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      buffer[0] <= 0;
      buffer[1] <= 0;
      buffer[2] <= 0;
      done <= 0;
    end else begin
      case(state)
        0: begin // Wait for first byte
          if (in[3] == 1'b1) begin
            buffer[0] <= in;
            state <= 1;
          end
        end
        1: begin // Receive second byte
          buffer[1] <= in;
          state <= 2;
        end
        2: begin // Receive third byte
          buffer[2] <= in;
          state <= 3;
        end
        3: begin // Signal message received
          done <= 1;
          state <= 0;
        end
      endcase
    end
  end

  assign first_byte = buffer[0];
  assign done = (state == 3);

endmodule
