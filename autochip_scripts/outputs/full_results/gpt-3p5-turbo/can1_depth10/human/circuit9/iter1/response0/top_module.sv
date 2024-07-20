module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    if (a) begin
      if (q == 3'b100)
        q <= 3'b101;
      else if (q == 3'b101)
        q <= 3'b110;
      else if (q == 3'b110)
        q <= 3'b000;
    end else begin
      if (q == 3'b000)
        q <= 3'b001;
      else if (q == 3'b001)
        q <= 3'b010;
      else if (q == 3'b010)
        q <= 3'b011;
      else if (q == 3'b011)
        q <= 3'b100;
      else if (q == 3'b100)
        q <= 3'b101;
      else if (q == 3'b101)
        q <= 3'b110;
      else if (q == 3'b110)
        q <= 3'b000;
    end
  end

endmodule
