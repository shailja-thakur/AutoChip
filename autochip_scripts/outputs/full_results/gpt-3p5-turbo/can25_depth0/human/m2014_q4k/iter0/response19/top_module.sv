module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

  reg [3:0] reg_value;
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      reg_value <= 4'b0;
    end else begin
      reg_value <= {reg_value[2:0], in};
    end
  end
  
  assign out = reg_value[3];
  
endmodule
