module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);
  
  always @(a, b, c, d) begin
    if (a < b && a < c && a < d) begin
      min = a;
    end
    else if (b < c && b < d) begin
      min = b;
    end
    else if (c < d) begin
      min = c;
    end
    else begin
      min = d;
    end
  end
  
endmodule
