module top_module (
  input clk,
  input resetn,
  input in,
  output out
);

  reg [3:0] shift_register;
  wire [3:0] shifted_out;
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      shift_register <= 4'b0;
    else
      shift_register <= {in, shift_register[3:1]};
  end

  assign out = shifted_out[0];

endmodule
