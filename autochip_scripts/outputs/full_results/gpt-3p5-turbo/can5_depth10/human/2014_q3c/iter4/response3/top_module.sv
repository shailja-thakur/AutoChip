module top_module (
   input clk,
   input x,
   input [2:0] y,
   output reg Y0,
   output reg z
);

   reg [2:0] next_state;
   always @(posedge clk) begin
      case ({x, y})
         2'b00: next_state <= 3'b001;
         2'b01: next_state <= 3'b100;
         2'b10: next_state <= 3'b001;
         2'b11: next_state <= 3'b010;
      endcase
   end

   always @(posedge clk) begin
      case (next_state)
         3'b000: begin
            Y0 <= 1'b0;
            z <= 1'b0;
         end
         3'b001: begin
            Y0 <= 1'b0;
            z <= 1'b0;
         end
         3'b010: begin
            Y0 <= 1'b1;
            z <= 1'b1;
         end
         3'b011: begin
            Y0 <= 1'b0;
            z <= 1'b1;
         end
         3'b100: begin
            Y0 <= 1'b1;
            z <= 1'b1;
         end
         default: begin
            Y0 <= 1'b0;
            z <= 1'b0;
         end
      endcase
   end
endmodule
