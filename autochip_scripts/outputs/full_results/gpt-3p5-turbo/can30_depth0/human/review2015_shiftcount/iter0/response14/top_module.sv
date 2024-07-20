module top_module (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);

  reg [3:0] register;

  always @(posedge clk) begin
    if (shift_ena && ~count_ena)
      register <= {q[2:0], data};
    else if (~shift_ena && count_ena)
      register <= register - 1;
    else if (shift_ena && count_ena)
      register <= register; // Priority given to shift_ena over count_ena
    else
      register <= register;
  end

  assign q = register;

endmodule
