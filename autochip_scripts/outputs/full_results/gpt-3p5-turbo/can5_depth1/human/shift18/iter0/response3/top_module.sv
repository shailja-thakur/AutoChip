module top_module(
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      case (amount)
        2'b00: q <= ena ? {q[62:0], q[63]} : q;
        2'b01: q <= ena ? {q[55:0], q[63:56]} : q;
        2'b10: q <= ena ? {q[0], q[63:1]} : q;
        2'b11: q <= ena ? {q[7:0], q[63:8]} : q;
      endcase
    end
  end

endmodule
