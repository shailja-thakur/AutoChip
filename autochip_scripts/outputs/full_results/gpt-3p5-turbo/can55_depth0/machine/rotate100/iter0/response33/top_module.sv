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
        2'b01: q_temp <= {q_temp[98:0], 1'b0}; // Shift left
        2'b10: q_temp <= {1'b0, q_temp[99:1]}; // Shift right
        default: q_temp <= q_temp;
      endcase
    end
  end

  always @(posedge clk) begin
    q <= q_temp;
  end
endmodule
