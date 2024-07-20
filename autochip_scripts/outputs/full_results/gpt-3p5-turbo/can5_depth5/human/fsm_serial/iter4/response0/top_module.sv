module fsm_serial (
    input clk,
    input in,
    input reset,
    output reg done
);

  reg [2:0] state;
  reg start_bit_detected;
  reg start_bit_correct;
  reg [7:0] data_bits;
  reg stop_bit_detected;
  reg [2:0] count;

  assign done = (state == 4) ? 1 : 0;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      count <= 0;
      start_bit_detected <= 0;
      start_bit_correct <= 0;
      data_bits <= 0;
      stop_bit_detected <= 0;
      done <= 0; // Reset done signal
    end else begin
      case (state)
        0: begin // Idle state
          if (in == 1) begin
            start_bit_detected <= 1;
            state <= 1;
          end
        end
        1: begin // Data bits state
          if (count == 7) begin
            state <= 2;
          end
          data_bits[count] <= in;
          count <= count + 1;
        end
        2: begin // Stop bit state
          if (in == 0) begin
            stop_bit_detected <= 1;
            state <= 3;
          end
        end
        3: begin // Verify stop bit state
          if (in == 0) begin
            start_bit_detected <= 0;
            state <= 0;
            done <= 1; // Byte received successfully
          end else if (in == 1) begin
            // Detected start bit for next byte
            start_bit_detected <= 1;
            state <= 1;
          end
        end
      endcase
    end
  end
endmodule
module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
  fsm_serial fsm (.clk(clk), .in(in), .reset(reset), .done(done));
endmodule
