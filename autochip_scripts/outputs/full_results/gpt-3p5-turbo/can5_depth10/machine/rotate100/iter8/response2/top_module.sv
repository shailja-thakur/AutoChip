module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);

  reg [1:0] ena_reg;
  reg [99:0] next_q;
  
  always @(posedge clk) begin
    if (load) begin
      ena_reg <= ena;
      q <= data;
    end else begin
      ena_reg <= ena;
      case (ena_reg)
        2'b01: next_q <= {q[98:0], q[99]};
        2'b10: next_q <= {q[0], q[99:1]};
        default: next_q <= q;
      endcase
    end
  end
  
  always @(posedge clk) begin
    if (!load)
      q <= next_q;
  end

endmodule
