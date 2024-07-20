module top_module(
  input clk,
  input [7:0] d,
  output reg [7:0] q
);
  
  reg [7:0] q_temp; // temporary register to store intermediate values
  
  always @(posedge clk) begin
    q_temp <= d; // update q_temp with input value d on every positive edge of clk
  end
  
  always @(posedge clk) begin
    q <= q_temp; // assign the value of q_temp to output register q on every positive edge of clk
  end
  
endmodule
