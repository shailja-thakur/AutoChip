module top_module (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);

  reg [2:0] state;
  reg [7:0] data_bits;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
      data_bits <= 8'b0;
      out_byte <= 8'b0;
      done <= 1'b0;
    end else begin
      case (state)
        3'b000: begin
          if (in == 1'b0) begin
            state <= 3'b001; // Transition to the start bit state
          end
        end
        3'b001: begin
          state <= 3'b010; // Transition to the data bits state
        end
        3'b010: begin
          if (in == 1'b1) begin
            data_bits <= {in, data_bits[7:1]}; // Shift in the received bit
          end
          
          if (data_bits == 8'b11111110) begin
            state <= 3'b011; // Transition to the stop bit state
          end
        end
        3'b011: begin
          if (in == 1'b1) begin
            out_byte <= data_bits; // Output the received byte
            done <= 1'b1;
            state <= 3'b000; // Transition back to the idle state
          end
        end
      endcase
    end
  end
  
endmodule
