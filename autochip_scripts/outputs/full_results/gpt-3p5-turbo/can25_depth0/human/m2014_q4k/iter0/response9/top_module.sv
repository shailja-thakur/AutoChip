module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
  reg [3:0] d;
  wire [3:0] q;
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      d <= 4'b0;
    else begin
      d[0] <= in;
      d[1] <= d[0];
      d[2] <= d[1];
      d[3] <= d[2];
    end
  end
  
  assign q = d;
  assign out = q[0];
endmodule
