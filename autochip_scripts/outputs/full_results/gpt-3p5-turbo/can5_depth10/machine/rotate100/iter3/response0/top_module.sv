module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);
  reg [99:0] q_temp;

  always @(posedge clk) begin
    if (load) begin
      q_temp <= data;
    end else begin
      case (ena)
        2'b01: q_temp <= {q_temp[98:0], 1'b0};
        2'b10: q_temp <= {1'b0, q_temp[99:1]};
        default: q_temp <= q_temp;
      endcase
    end
  end
  
  always @(q_temp) begin
    q <= q_temp;
  end
endmodule
