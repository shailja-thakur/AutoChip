module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state;
  
  always @(posedge clk) begin
    if (reset)
      state <= 3'b000; // state A
    else if (state == 3'b000) begin // state A
      if (w)
        state <= 3'b000; // state A
      else
        state <= 3'b001; // state B
    end else if (state == 3'b001) begin // state B
      if (w)
        state <= 3'b011; // state D
      else
        state <= 3'b010; // state C
    end else if (state == 3'b010) begin // state C
      if (w)
        state <= 3'b011; // state D
      else
        state <= 3'b100; // state E
    end else if (state == 3'b011) begin // state D
      if (w)
        state <= 3'b000; // state A
      else
        state <= 3'b101; // state F
    end else if (state == 3'b100) begin // state E
      if (w)
        state <= 3'b011; // state D
      else
        state <= 3'b100; // state E
    end else begin // state F
      if (w)
        state <= 3'b011; // state D
      else
        state <= 3'b010; // state C
    end
  end
  
  always @(state) begin
    if (state == 3'b100 || state == 3'b101)
      z <= 1'b1;
    else
      z <= 1'b0;
  end

endmodule
