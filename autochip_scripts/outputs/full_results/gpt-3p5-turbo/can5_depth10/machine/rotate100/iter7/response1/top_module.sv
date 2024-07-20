module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);

  reg [1:0] ena_reg;
  reg [1:0] next_ena_reg;
  
  always @(posedge clk) begin
    ena_reg <= next_ena_reg;
    if (load) begin
      q <= data;
    end else begin
      case (ena_reg)
        2'b01: q <= {q[98:0], q[99]};
        2'b10: q <= {q[0], q[99:1]};
        default: q <= q;
      endcase
    end
  end
  
  always @(posedge clk) begin
    next_ena_reg <= ena;
  end

endmodule
