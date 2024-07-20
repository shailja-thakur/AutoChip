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
  wire stop_bit_correct;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      start_bit_detected <= 0;
      start_bit_correct <= 0;
      data_bits <= 0;
      stop_bit_detected <= 0;
      done <= 0;
    end else begin
      case (state)
        0: begin // Idle state
          if (in == 0) begin
            start_bit_detected <= 1;
            state <= 1;
          end
        end
        1: begin // Data bits state
          if (in == 1) begin
            data_bits <= {data_bits[6:0], in};
          end
          state <= 2;
        end
        2: begin // Stop bit state
          if (in == 1) begin
            stop_bit_detected <= 1;
            state <= 3;
          else
            state <= 0; // go back to idle if stop bit not detected
          end
        end
        3: begin // Verify stop bit state
          if (stop_bit_detected && in == 0 && start_bit_detected) begin
            if (data_bits == 8'b10000000) begin
              start_bit_detected <= 0;
              start_bit_correct <= 1;
              done <= 1;
            end else begin
              done <= 0;
            end
          end
          state <= 0; // go back to idle
        end
      endcase
    end
  end

endmodule
