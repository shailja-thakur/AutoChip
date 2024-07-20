module top_module (   input [7:0] a,   input [7:0] b,   output [7:0] s,   output overflow );
  reg [8:0] sum;
  assign s = sum[7:0];
  assign overflow = sum[8];
  
  always @ (a or b) begin
    sum = a + b;
  end
  
  always @ (sum) begin
    if (sum[8] == 1) begin
      overflow = 1;
    end else begin
      overflow = 0;
    end
  end
endmodule
