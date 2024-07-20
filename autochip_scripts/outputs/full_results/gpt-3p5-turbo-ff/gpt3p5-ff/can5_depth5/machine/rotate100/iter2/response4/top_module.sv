module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q);

reg [99:0] q_reg;
reg [1:0] direction;

always @(posedge clk) begin
  if (load)
    q_reg <= data;
  else begin
    case (ena)
      2'b01: begin
        q_reg <= {q_reg[98:0], 1'b0};
        direction <= 2'b01;
      end
      2'b10: begin
        q_reg <= {1'b0, q_reg[99:1]};
        direction <= 2'b10;
      end
      default: begin
        if (direction == 2'b01)
          q_reg <= {q_reg[98:0], 1'b0};
        else if (direction == 2'b10)
          q_reg <= {1'b0, q_reg[99:1]};
        else
          q_reg <= q_reg;
      end
    endcase
  end
end

assign q = q_reg;

endmodule
