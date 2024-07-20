module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);

  reg [7:0] prev_in;
  
  always @(posedge clk) begin
    prev_in <= in;
  end
  
  always @(posedge clk) begin
    for (integer i = 0; i < 8; i = i + 1) begin
      if (prev_in[i] == 0 && in[i] == 1) begin
        pedge[i] <= 1;
      end else if (prev_in[i] == 1 && in[i] == 0) begin
        pedge[i] <= 0;
      end else begin
        // keep the previous output state if no transition occurred
        pedge[i] <= pedge[i];
      end
    end
  end
endmodule
