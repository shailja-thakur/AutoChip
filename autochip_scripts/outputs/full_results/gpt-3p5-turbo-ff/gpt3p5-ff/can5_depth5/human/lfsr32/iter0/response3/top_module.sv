module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] shift_reg;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      shift_reg <= 32'b1;
    end else begin
      shift_reg <= {q[31]^q[21]^q[1]^q[0], shift_reg[31:1]};
    end
  end
  
  assign q = shift_reg;
  
endmodule
