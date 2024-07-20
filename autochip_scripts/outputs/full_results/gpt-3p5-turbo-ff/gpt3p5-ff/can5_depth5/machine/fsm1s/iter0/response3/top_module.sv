module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);

  reg [1:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b1;
    end else begin
      if (state == 2'b1) begin
        state <= in ? 2'b1 : 2'b0;
      end else if (state == 2'b0) begin
        state <= in ? 2'b0 : 2'b1;
      end
    end
  end
  
  assign out = (state == 2'b1) ? 1'b1 : 1'b0;

endmodule
