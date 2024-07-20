module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 0;
    else begin
      case (state)
        2'b00: begin
          if (in[2] == 1)
            state <= 2'b01;
          else
            state <= 2'b00;
        end
        2'b01: begin
          state <= 2'b10;
        end
        2'b10: begin
          state <= 2'b11;
        end
        2'b11: begin
          state <= 2'b00;
        end
      endcase
    end
  end
  
  always @(posedge clk)
    if (state == 2'b11)
      done <= 1;
    else
      done <= 0;

  always @(posedge clk) begin
    if (state == 2'b11)
      out_bytes <= out_bytes;
    else begin
      out_bytes <= {out_bytes[15:0], in};
    end
  end
    
endmodule
