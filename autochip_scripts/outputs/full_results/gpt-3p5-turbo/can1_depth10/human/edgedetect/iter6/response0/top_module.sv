module top_module(
  input clk,
  input [7:0] in,
  output [7:0] pedge
);

  reg [7:0] prev_in;
  reg [7:0] edge_detect;
  
  always @(posedge clk) begin
    prev_in <= in;
  end
  
  always @(posedge clk) begin
    for (integer i = 0; i < 8; i = i + 1) begin
      if (prev_in[i] == 0 && in[i] == 1) begin
        edge_detect[i] <= 1;
      end else if (prev_in[i] == 1 && in[i] == 0) begin
        edge_detect[i] <= 0;
      end else begin
        // keep the previous output state if no transition occurred
        edge_detect[i] <= edge_detect[i];
      end
    end
  end
  
  always @(posedge clk) begin
    pedge <= edge_detect;
  end
endmodule
