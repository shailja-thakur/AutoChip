module top_module (
   input clk,
   input [7:0] in,
   output reg [7:0] anyedge
);

reg [7:0] in_reg;
reg [7:0] in_prev;

always @(posedge clk) begin
   in_reg <= in;
   in_prev <= in_reg;
   anyedge <= 0;
   for (i = 0; i < 8; i = i + 1) begin
      if (in_reg[i] != in_prev[i]) begin
         anyedge[i] <= in_reg[i];
      end
   end
end

endmodule
