module top_module (
	input signed [7:0] a,
	input signed [7:0] b,
	output signed [7:0] s,
	output overflow
);
  
  reg [8:0] temp;
  
  always @* begin
    temp = a + b;
    s = temp[7:0];
    if (temp[8] == 1) begin
      overflow = 1;
    end
    else begin
      overflow = 0;
    end
  end
  
endmodule
