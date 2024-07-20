module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 0;
      ena <= 0;
    end
    else begin
      if (q[3:1] == 3'b100) begin
        q <= q + 4'b001;
        ena <= 3'b111;
      end
      else begin
        q <= q + 1;
        ena <= ena & (~q[3:1]);
      end
   end
  end

endmodule
