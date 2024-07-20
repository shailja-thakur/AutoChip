module top_module (
  input clk,
  input resetn,
  input in,
  output out
);

  reg [3:0] d; // D input signals
  reg         q; // Output signal
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      d <= 4'b0; // Reset to 0
    else
      d <= {d[2:0], in}; // Shift values and store new input
  end
  
  assign out = q;
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      q <= 1'b0; // Reset to 0
    else
      q <= d[3]; // Output the most significant bit
  end

endmodule
