module top_module (
	input clk,
	input areset,
	input x,
	output z
);

  reg [7:0] xn;
  reg [7:0] zn;

  always @(posedge clk or negedge areset) begin
    if(!areset) begin
      xn <= 8'b00000000;
      zn <= 8'b00000000;
    end else begin
      if (x) begin
        xn <= {xn[6:0], x};
        zn <= ~xn + 1;
      end
    end
  end

  assign z = zn[0];

endmodule
