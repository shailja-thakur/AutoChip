module top_module (
	input clk,
	input areset,
	input x,
	output z
);
  reg [1:0] state;
  reg z;
  
  always @(posedge clk or negedge areset)
  begin
    if (areset == 0)
      state <= 0;
    else if (state == 0 && areset == 1)
    begin
      state <= 1;
      z <= 0;
    end
    else if (state == 1)
    begin
      z <= ~x;
      if (x == 1)
        state <= 2;
    end
    else if (state == 2)
    begin
      z <= ~z;
      state <= 1;
    end
  end
endmodule
