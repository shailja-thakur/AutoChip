module top_module (
   input clk,
   input resetn,
   input in,
   output out
);

reg [3:0] d_ff;
wire [3:0] d;

assign d = {d_ff[2:0], in};

always @(posedge clk or negedge resetn) begin
   if (!resetn)
      d_ff <= 4'b0;
   else
      d_ff <= d;
end

assign out = d_ff[3];

endmodule
