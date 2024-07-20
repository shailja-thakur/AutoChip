module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);

  // Variables
  always @(posedge clk or negedge ar)
  begin
    if (ar == 0)
      q <= 0;
    else
      q <= d;
  end

endmodule
