module top_module(
  input clk,
  input reset,
  output reg [31:0] q);
  
  reg [31:0] feedback;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      feedback <= 32'hFFFFFFFF;
      q <= 32'h1;
    end else begin
      feedback <= {feedback[30:0], feedback[0]} ^ {feedback[20:0], feedback[0], feedback[31], feedback[1]};
      q <= feedback[31:0];
    end
  end

endmodule
