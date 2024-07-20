module top_module (
  input clk,
  input in,
  input reset,
  output done
);
  
  reg [2:0] state;
  reg start_bit_detected;
  reg start_bit_correct;
  reg [7:0] data_bits;
  reg stop_bit_detected;

  assign done = (state == 4) ? 1 : 0;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
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
          data_bits <= {data_bits[6:0], in};
          if (start_bit_detected && (data_bits == 8'b11111110)) begin
            start_bit_correct <= 1;
            state <= 2;
          end
        end
        2: begin // Stop bit state
          if (in == 1) begin
            stop_bit_detected <= 1;
            state <= 3;
          end
        end
        3: begin // Verify stop bit state
          if (!start_bit_detected && (in == 1)) begin
            // Detected start bit for next byte
            start_bit_detected <= 1;
            state <= 1;
          end else if (!start_bit_detected && (in == 0)) begin
            // Detected start bit for next byte, but no stop bit
            start_bit_detected <= 1;
            state <= 2;
          end else if (start_bit_detected && (in == 1)) begin
            // Start bit detected in the middle of a byte
            start_bit_detected <= 1;
            state <= 1;
          end
        end
      endcase
    end
  end
endmodule
