module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  // Variable declarations
  reg [98:0] out_both_reg;
  reg [99:1] out_any_reg;
  reg [99:0] out_different_reg;
  
  // Output assignments
  assign out_both = out_both_reg;
  assign out_any = out_any_reg;
  assign out_different = out_different_reg;
  
  // Logic for out_both
  always @* begin
    for (int i = 0; i < 99; i = i + 1) begin
      out_both_reg[i] = (in[i] == 1) && (in[i+1] == 1);
    end
  end
  
  // Logic for out_any
  always @* begin
    for (int i = 1; i < 100; i = i + 1) begin
      out_any_reg[i] = (in[i] == 1) || (in[i-1] == 1);
    end
    out_any_reg[0] = 0; // Set out_any[0] to 0 since in[0] has no neighbor to the right
  end
  
  // Logic for out_different
  always @* begin
    for (int i = 0; i < 100; i = i + 1) begin
      out_different_reg[i] = (in[i] != in[(i+99)%100]);
    end
  end

endmodule
