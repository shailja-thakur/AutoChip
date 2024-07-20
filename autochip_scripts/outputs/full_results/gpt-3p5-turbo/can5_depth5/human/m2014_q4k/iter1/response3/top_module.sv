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
      shift_register <= 4'b1111; // reset to all 1's
    else
      shift_register <= {shift_register[2:0], in};
  end

  assign out = shifted_out[0];

  assign shifted_out = shift_register;

endmodule
