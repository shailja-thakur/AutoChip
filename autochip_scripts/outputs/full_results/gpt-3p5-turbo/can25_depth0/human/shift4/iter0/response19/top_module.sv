module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q);

  reg [3:0] temp;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      temp <= 4'b0;
    end else begin
      if (load) begin
        temp <= data;
      end else if (ena) begin
        temp <= {temp[2:0], 1'b0};
      end
    end
  end

  assign q = temp;
  
endmodule
