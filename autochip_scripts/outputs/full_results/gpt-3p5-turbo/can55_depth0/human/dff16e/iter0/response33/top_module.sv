module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);
  
  reg [15:0] q_temp; //temporary register to store updated values
  
  always @(posedge clk or negedge resetn)
  begin
    if (!resetn)
      q <= 16'b0; //reset all flip-flops to 0
    else if (byteena[1])
      q_temp[15:8] <= d[15:8]; //update upper byte
    else
      q_temp[15:8] <= q[15:8]; //keep upper byte unchanged
      
    //same logic for lower byte
    if (byteena[0])
      q_temp[7:0] <= d[7:0]; //update lower byte
    else
      q_temp[7:0] <= q[7:0]; //keep lower byte unchanged
    
    q <= q_temp; //update the output register
  end
endmodule
