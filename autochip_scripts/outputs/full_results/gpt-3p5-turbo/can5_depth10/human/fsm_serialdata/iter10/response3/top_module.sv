module top_module (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);

  reg [2:0] state;
  reg [2:0] counter;
  reg [7:0] rx_data;
  reg [1:0] stop_count;
  reg last_in;
  wire start_bit;
  wire [7:0] data_bits;
  wire stop_bit;

  assign start_bit = (in == 1'b0 && last_in == 1'b1);
  assign data_bits = {rx_data[6:0], in};
  assign stop_bit = (stop_count == 2'b01 && in == 1'b1);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
      counter <= 3'b000;
      rx_data <= 8'b0;
      stop_count <= 2'b00;
      done <= 1'b0;
    end else begin
      case (state)
        3'b000: begin  // Idle state
          if (start_bit) begin  // Transition to receive state
            state <= 3'b001;
            counter <= 3'b000;
            rx_data <= 8'b0;
          end
        end
        3'b001: begin  // Receive state
          if (counter == 3'b111) begin  // Reached all 8 data bits
            state <= 3'b010;
            counter <= 3'b000;
          end else begin  // Continue receiving data bits
            counter <= counter + 1;
            rx_data <= data_bits;
          end
        end
        3'b010: begin  // Verify stop bit state
          if (stop_bit) begin  // Stop bit is correct
            state <= 3'b011;
            out_byte <= rx_data;
            done <= 1'b1;
          end else if (!stop_bit && in == 1'b0) begin  // Stop bit did not appear yet, wait
            state <= 3'b010;
          end else begin  // Invalid stop bit, reset
            state <= 3'b000;
            done <= 1'b0;
          end
        end
        3'b011: begin  // Done state
          state <= 3'b000;
          done <= 1'b0;
        end
      endcase
      last_in <= in;
    end
  end

endmodule
