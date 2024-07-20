module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);
  
  reg [7:0] previous_in;

  always @(posedge clk) begin
    previous_in <= in;
    
    for (int i = 0; i < 8; i = i + 1) begin
      if (previous_in[i] == 0 && in[i] == 1) begin
        pedge[i] <= 1;
      end
    end
  end
endmodule
