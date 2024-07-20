module top_module (
  input clk,
  input resetn,
  input in,
  output out
);

reg [3:0] d_ff;
reg [3:0] shifted;
  
always @(posedge clk or negedge resetn) begin
  if (!resetn)
    d_ff <= 4'b0000;
  else begin
    d_ff[0] <= in;
    d_ff[1] <= d_ff[0];
    d_ff[2] <= d_ff[1];
    d_ff[3] <= d_ff[2];
  end
end

assign out = d_ff[3];

endmodule
