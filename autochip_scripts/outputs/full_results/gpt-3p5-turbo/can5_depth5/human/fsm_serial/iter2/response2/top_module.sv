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
  reg [2:0] count;

  assign done = (state == 4) ? 1'b1 : 1'b0;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
      count <= 3'b000;
      start_bit_detected <= 1'b0;
      start_bit_correct <= 1'b0;
      data_bits <= 8'b0;
      stop_bit_detected <= 1'b0;
    end else begin
      case (state)
        3'b000: begin // Idle state
          if (in == 1'b0) begin
            start_bit_detected <= 1'b1;
            state <= 3'b001;
          end
        end
        3'b001: begin // Data bits state
          if (count == 3'b111) begin
            state <= 3'b010;
          end
          data_bits[count] <= in;
          count <= count + 1'b1;
        end
        3'b010: begin // Stop bit state
          if (in == 1'b1) begin
            stop_bit_detected <= 1'b1;
            state <= 3'b011;
          end
        end
        3'b011: begin // Verify stop bit state
          if (in == 1'b1) begin
            if (start_bit_detected == 1'b1) begin
              start_bit_detected <= 1'b0;
              start_bit_correct <= 1'b1;
            end
            state <= 3'b000;
          end else if (in == 1'b0) begin
            // Detected start bit for next byte
            start_bit_detected <= 1'b1;
            start_bit_correct <= 1'b0;
            state <= 3'b001;
          end
        end
      endcase
    end
  end
endmodule
