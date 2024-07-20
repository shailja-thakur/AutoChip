module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);
  
  reg [7:0] q_upper_byte;
  reg [7:0] q_lower_byte;
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      q_upper_byte <= 8'b0;
      q_lower_byte <= 8'b0;
    end else begin
      if (byteena[1]) begin
        q_upper_byte <= d[15:8];
      end
      if (byteena[0]) begin
        q_lower_byte <= d[7:0];
      end
    end
  end
  
  always @* begin
    q = {q_upper_byte, q_lower_byte};
  end

endmodule
