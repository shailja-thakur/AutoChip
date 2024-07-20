module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] shift_register;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      shift_register <= 32'b0;
    else
      shift_register <= {shift_register[31:1], shift_register[22] ^ shift_register[2] ^ shift_register[1]};
  end
  
  always @* begin
    q = (reset) ? 32'h1 : shift_register;
  end
  
endmodule
