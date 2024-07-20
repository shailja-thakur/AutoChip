module top_module (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

  // Declare internal signals
  reg [7:0] data_byte;
  reg start_bit;
  reg [2:0] state;

  // Synchronous reset
  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      data_byte <= 8'b0;
      start_bit <= 1'b0;
    end else begin
      case (state)
        0: begin
          // Wait for start bit
          if (in == 1'b0) begin
            state <= 1;
            start_bit <= 1'b1;
          end
        end
        1: begin
          // Receive data bits
          data_byte <= {data_byte[6:0], in};
          state <= state + 1;
        end
        8: begin
          // Verify stop bit
          if (in == 1'b1 && start_bit == 1'b1) begin
            state <= 0;
            out_byte <= data_byte;
            done <= 1'b1;
          end
        end
        default: begin
          // Wait for stop bit
          if (in == 1'b1) begin
            state <= 0;
            done <= 1'b0;
          end
        end
      endcase
    end
  end

endmodule
