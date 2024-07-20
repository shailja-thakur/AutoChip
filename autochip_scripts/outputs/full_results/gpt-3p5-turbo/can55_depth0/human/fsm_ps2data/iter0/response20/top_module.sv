module top_module (
   input clk,
   input [7:0] in,
   input reset,
   output [23:0] out_bytes,
   output done
);

reg [7:0] in_reg;
reg [23:0] out_bytes_reg;
reg done_reg;

always @(posedge clk) begin
   if (reset) begin
      in_reg <= 8'b0;
      out_bytes_reg <= 24'b0;
      done_reg <= 1'b0;
   end else begin
      if (done_reg) begin
         out_bytes_reg <= 24'b0;
         done_reg <= 1'b0;
      end else begin
         in_reg <= in;
         if (out_bytes_reg[23:16] == 8'b0 && in[3] == 1'b1) begin
            out_bytes_reg <= {in_reg, out_bytes_reg[15:0]};
         end else if (out_bytes_reg[15:8] == 8'b0 && out_bytes_reg[23:16] != 8'b0) begin
            out_bytes_reg <= {in_reg, out_bytes_reg[23:8]};
         end else if (out_bytes_reg[15:8] != 8'b0 && out_bytes_reg[23:16] != 8'b0) begin
            out_bytes_reg <= {in_reg, out_bytes_reg[23:8]};
            done_reg <= 1'b1;
         end
      end
   end
end

assign out_bytes = out_bytes_reg;
assign done = done_reg;

endmodule
