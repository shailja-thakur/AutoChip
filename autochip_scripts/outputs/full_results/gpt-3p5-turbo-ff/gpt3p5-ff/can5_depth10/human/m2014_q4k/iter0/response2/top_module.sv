module top_module (
   input clk,
   input resetn,
   input in,
   output out
);

reg [3:0] d;
reg out;

always @(posedge clk or negedge resetn)
   if (!resetn)
      d <= 4'b0;
   else
      d <= {d[2:0], in};

assign out = d[3];

endmodule
