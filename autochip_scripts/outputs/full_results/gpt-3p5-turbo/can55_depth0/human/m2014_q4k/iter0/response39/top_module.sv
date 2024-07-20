module top_module (
  input clk,
  input resetn,
  input in,
  output out
);
  
  reg [3:0] d_flops;
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      d_flops <= 4'b0;
    end else begin
      d_flops <= {d_flops[2:0], in};
    end
  end
  
  assign out = d_flops[3];
  
endmodule
