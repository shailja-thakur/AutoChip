module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);
  reg [7:0] in_prev;
  
  always @(posedge clk) begin
    // Detect positive edge transition for each bit
    for (int i = 0; i < 8; i = i + 1) begin
      if (in[i] == 1 && in_prev[i] == 0) begin
        pedge[i] <= 1;
      end else begin
        pedge[i] <= 0;
      end
    end
    
    in_prev <= in;
  end
endmodule
