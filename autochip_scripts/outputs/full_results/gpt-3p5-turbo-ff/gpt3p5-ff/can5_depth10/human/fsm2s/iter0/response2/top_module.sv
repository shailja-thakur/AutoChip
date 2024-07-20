module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);
  
  reg [1:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b0;
      out <= 1'b0;
    end
    else begin
      case (state)
        2'b00: begin
          if (j)
            state <= 2'b01;
          else
            state <= 2'b00;
          out <= 1'b0;
        end
        2'b01: begin
          if (k)
            state <= 2'b00;
          else
            state <= 2'b01;
          out <= 1'b1;
        end
      endcase
    end
  end
  
endmodule
