module top_module (
  input clk,
  input in,
  input reset,
  output wire out
);

  reg [1:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00;  // reset to state A
    end else begin
      case (state)
        2'b00: begin  // State A
          if (in) begin
            state <= 2'b01;  // Next state in=1, B
            out <= 1'b0;  // Output 0
          end else begin
            state <= 2'b00;  // Next state in=0, A
            out <= 1'b0;  // Output 0
          end
        end
          
        2'b01: begin  // State B
          if (in) begin
            state <= 2'b01;  // Next state in=1, B
            out <= 1'b0;  // Output 0
          end else begin
            state <= 2'b10;  // Next state in=0, C
            out <= 1'b0;  // Output 0
          end
        end
          
        2'b10: begin  // State C
          if (in) begin
            state <= 2'b00;  // Next state in=1, A
            out <= 1'b0;  // Output 0
          end else begin
            state <= 2'b11;  // Next state in=0, D
            out <= 1'b0;  // Output 0
          end
        end
          
        2'b11: begin  // State D
          if (in) begin
            state <= 2'b10;  // Next state in=1, C
            out <= 1'b1;  // Output 1
          end else begin
            state <= 2'b01;  // Next state in=0, B
            out <= 1'b0;  // Output 0
          end
        end
      endcase
    end
  end
endmodule
