module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
  
  reg [23:0] out_bytes_reg;
  reg [7:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 0;
    else begin
      case (state)
        0: if (in[2]) state <= 1; else state <= 0;
        1: state <= 2;
        2: state <= 3;
        3: state <= 0;
      endcase
    end
  end
  
  always @(posedge clk) begin
    if (state == 0 || state == 3) begin
      out_bytes_reg <= in;
    end else begin
      out_bytes_reg <= {out_bytes_reg[15:0], out_bytes_reg[23:16]};
    end
  end
  
  assign done = (state == 3);
  assign out_bytes = out_bytes_reg;
  
endmodule
