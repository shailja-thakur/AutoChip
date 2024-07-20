module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  // Declare required signals and variables
  reg R_temp;
  wire MUX_output;
  
  // Flip-flop
  always @(posedge clk) begin
    if (E) begin
      R_temp <= R;
      Q <= MUX_output;
    end
  end

  // Multiplexer
  assign MUX_output = (L) ? R : w;

endmodule
