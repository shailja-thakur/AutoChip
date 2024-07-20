module top_module (
  input clk,
  input resetn,
  input in,
  output out
);

  reg [3:0] shift_register;
  reg [3:0] shifted_out;

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      shift_register <= 4'b0;
    else
      shift_register <= {shift_register[2:0], in};
  end

  assign out = shift_register[0];

endmodule
