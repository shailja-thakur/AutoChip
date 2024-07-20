module top_module (
  input clk,
  input in,
  input reset,
  output reg done
);

  reg [3:0] state;
  reg start_bit;
  reg [7:0] data_bits;
  reg stop_bit;
  wire valid_byte;
  
  // Start state
  initial begin
    state = 4'b0000;
    start_bit = 0;
    stop_bit = 0;
    data_bits = 8'b0;
    done = 0;
  end
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 4'b0000;
      start_bit <= 0;
      stop_bit <= 0;
      data_bits <= 8'b0;
      done <= 0;
    end
    else begin
      case (state)
        // State 0: Waiting for start bit
        4'b0000: begin
          if (in == 0) begin
            start_bit <= 1;
            state <= 4'b0001;
          end
        end
        
        // State 1-8: Receiving data bits
        4'b0001: begin
          if (in == 1) begin
            data_bits <= {data_bits[6:0], in};
            state <= state + 1;
          end
        end
        4'b0010: begin
          if (in == 1) begin
            data_bits <= {data_bits[5:0], in};
            state <= state + 1;
          end
        end
        4'b0011: begin
          if (in == 1) begin
            data_bits <= {data_bits[4:0], in};
            state <= state + 1;
          end
        end
        4'b0100: begin
          if (in == 1) begin
            data_bits <= {data_bits[3:0], in};
            state <= state + 1;
          end
        end
        4'b0101: begin
          if (in == 1) begin
            data_bits <= {data_bits[2:0], in};
            state <= state + 1;
          end
        end
        4'b0110: begin
          if (in == 1) begin
            data_bits <= {data_bits[1:0], in};
            state <= state + 1;
          end
        end
        4'b0111: begin
          if (in == 1) begin
            data_bits <= {data_bits[0], in};
            state <= state + 1;
          end
        end
        
        // State 9: Waiting for stop bit
        4'b1000: begin
          if (in == 1) begin
            stop_bit <= 1;
            state <= 4'b1001;
          end
        end
        
        // State 10: Byte received, reset state
        4'b1001: begin
          if (stop_bit == 1 && valid_byte) begin
            done <= 1;
            state <= 4'b0000;
            start_bit <= 0;
            stop_bit <= 0;
            data_bits <= 8'b0;
          end
          else begin
            if (in == 1 && stop_bit == 1) begin
              valid_byte <= 1;
            end
            else begin
              valid_byte <= 0;
            end
          end
        end
      endcase
    end
  end
endmodule
