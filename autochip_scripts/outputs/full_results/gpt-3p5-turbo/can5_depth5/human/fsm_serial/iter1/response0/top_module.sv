module top_module (
  input clk,
  input in,
  input reset,
  output done
);
  
  reg [3:0] state;
  reg start_bit_detected;
  reg start_bit_correct;
  reg [7:0] data_bits;
  wire stop_bit_correct;
  reg stop_bit_detected;

  assign stop_bit_correct = (state == 4) ? 1'b1 : 1'b0;
  assign done = (state == 4 && stop_bit_detected) ? 1'b1 : 1'b0;

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
            start_bit_detected <= 1'b1;
            state <= 1;
          end
        end
        1: begin // Data bits state
          data_bits <= {data_bits[6:0], in};
          state <= 2;
        end
        2: begin // Stop bit state
          if (in == 1) begin
            stop_bit_detected <= 1'b1;
            state <= 3;
          end
        end
        3: begin // Verify stop bit state
          if (stop_bit_correct) begin
            state <= 4;
          end else if (in == 0) begin
            // Detected start bit for next byte
            start_bit_detected <= 1'b1;
            state <= 1;
          end
        end
        4: begin // Idle state after stop bit
          if (in == 0) begin
            // Detected start bit for next byte
            start_bit_detected <= 1'b1;
            state <= 1;
          end
        end
      endcase
    end
  end

endmodule
