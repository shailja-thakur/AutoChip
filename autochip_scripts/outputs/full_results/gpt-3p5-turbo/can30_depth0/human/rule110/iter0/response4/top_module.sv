module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q[511] <= q[510];
      q[510:0] <= {q[509], q[508:0]};
      q[512] <= q[511];
      case({q[511], q[510], q[509]})
        3'b000: q[511] <= 1'b0;
        3'b001: q[511] <= 1'b1;
        3'b010: q[511] <= 1'b1;
        3'b011: q[511] <= 1'b0;
        3'b100: q[511] <= 1'b1;
        3'b101: q[511] <= 1'b1;
        3'b110: q[511] <= 1'b1;
        3'b111: q[511] <= 1'b0;
      endcase
    end
  end

endmodule
