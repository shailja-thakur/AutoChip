module top_module (
  input clk,
  input resetn,
  input in,
  output out
);
  
  reg [3:0] shift_register;
  
  always @(posedge clk or negedge resetn)
  begin
    if (~resetn)
      shift_register <= 4'h0;
    else
    begin
      shift_register[0] <= in;
      shift_register[1] <= shift_register[0];
      shift_register[2] <= shift_register[1];
      shift_register[3] <= shift_register[2];
    end
  end
  
  assign out = shift_register[3];
  
endmodule
