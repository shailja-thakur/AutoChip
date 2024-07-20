module top_module (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);

  // Define states
  localparam IDLE = 2'b00;
  localparam RECEIVING = 2'b01;
  localparam STOP_BIT = 2'b10;
  
  // Define signals
  reg [1:0] state;
  reg [3:0] bit_counter;
  reg [7:0] received_byte;
  reg [1:0] last_two_bits;
  
  // Activate reset on rising edge of clk
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      bit_counter <= 0;
      received_byte <= 0;
      last_two_bits <= 0;
      done <= 0;
      out_byte <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (in == 1'b0) begin
            state <= RECEIVING;
            received_byte <= 0;
            bit_counter <= 0;
          end
        end
        RECEIVING: begin
          bit_counter <= bit_counter + 1;
          received_byte <= {in, received_byte[7:1]};
          if (bit_counter == 7) begin
            state <= STOP_BIT;
          end
        end
        STOP_BIT: begin
          bit_counter <= bit_counter + 1;
          last_two_bits <= {in, last_two_bits[1]};
          if (last_two_bits == 2'b11) begin
            out_byte <= received_byte;
            done <= 1;
            state <= IDLE;
            bit_counter <= 0;
            received_byte <= 0;
            last_two_bits <= 0;
          end else if (bit_counter == 15) begin
            state <= IDLE;
            bit_counter <= 0;
            received_byte <= 0;
            last_two_bits <= 0;
          end
        end
      endcase
    end
  end

endmodule
