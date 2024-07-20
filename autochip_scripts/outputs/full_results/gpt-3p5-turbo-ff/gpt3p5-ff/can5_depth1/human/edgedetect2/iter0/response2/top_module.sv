module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge);
  
  reg [7:0] in_prev; // Previous input signal

  always @(posedge clk) begin
    in_prev <= in; // Store the current input signal
    anyedge <= 0; // Reset output bit
    
    for (int i = 0; i < 8; i = i + 1) begin
      if (in_prev[i] == 0 && in[i] == 1) begin
        anyedge[i] <= 1; // Detect 0 to 1 transition
      end
    end
  end
endmodule
