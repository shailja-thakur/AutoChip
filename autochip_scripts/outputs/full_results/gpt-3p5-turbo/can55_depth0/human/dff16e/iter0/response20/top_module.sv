module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q
);

  reg [7:0] q_lower; // register for lower byte q[7:0]
  reg [7:0] q_upper; // register for upper byte q[15:8]
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      q_lower <= 8'b0; // reset lower byte to 0
      q_upper <= 8'b0; // reset upper byte to 0
    end else begin
      if (byteena[0]) begin
        q_lower <= d[7:0]; // update lower byte if byteena[0] is high
      end
      
      if (byteena[1]) begin
        q_upper <= d[15:8]; // update upper byte if byteena[1] is high
      end
    end
  end
  
  assign q = {q_upper, q_lower}; // concatenate lower and upper bytes to form q

endmodule
