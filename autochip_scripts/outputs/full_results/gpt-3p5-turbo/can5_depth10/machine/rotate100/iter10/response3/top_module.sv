module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);

  reg [1:0] ena_reg;
  reg [99:0] q_reg;
  
  always @(posedge clk) begin
    ena_reg <= ena;
    q_reg <= q;
    
    if (load) begin
      q <= data;
    end else begin
      case (ena_reg)
        2'b01: q <= {q_reg[98:0], q_reg[99]};
        2'b10: q <= {q_reg[0], q_reg[99:1]};
        default: q <= q_reg;
      endcase
    end
  end

endmodule
