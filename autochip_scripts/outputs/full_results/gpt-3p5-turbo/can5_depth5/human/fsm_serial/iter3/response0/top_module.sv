module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

  reg [3:0] state;
  reg start_bit_detected;
  reg start_bit_correct;
  reg [7:0] data_bits;
  reg stop_bit_detected;
  reg [6:0] count;

  assign done = (state == 4) & (count == 7); // Update condition for done signal

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      count <= 0;
      start_bit_detected <= 0;
      start_bit_correct <= 0;
      data_bits <= 0;
      stop_bit_detected <= 0;
    end else begin
      case (state)
        0: begin // Idle state
          if (in == 0) begin
            start_bit_detected <= 1;
            state <= 1;
          end
        end
        1: begin // Data bits state
          if (count == 6) begin
            state <= 2;
          end
          data_bits[count] <= in;
          count <= count + 1;
        end
        2: begin // Stop bit state
          if (in == 1) begin
            stop_bit_detected <= 1;
            state <= 3;
          end else begin
            // Incorrect stop bit, restart receiving
            state <= 0;
          end
        end
        3: begin // Verify stop bit state
          if (in == 1) begin
            start_bit_detected <= 0;
            state <= 0;
          end else if (in == 0) begin
            // Detected start bit for next byte
            start_bit_detected <= 1;
            state <= 1;
          end
        end
      endcase
    end
  end
endmodule
