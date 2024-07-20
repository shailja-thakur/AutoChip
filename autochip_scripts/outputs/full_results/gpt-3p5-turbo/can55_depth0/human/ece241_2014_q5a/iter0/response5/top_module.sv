module top_module (
  input clk,
  input areset,
  input x,
  output z
);

reg [2:0] state;
reg z;
wire reset;

assign reset = areset || z;
  
always @(posedge clk or posedge reset) begin
  if (reset)
    state <= 0;
  else begin
    case (state)
      0: begin
        if (x)
          state <= 1;
        else
          state <= 0;
      end
      1: begin
        state <= 2;
      end
      2: begin
        state <= 3;
      end
      3: begin
        state <= 0;
      end
    endcase
  end
end

always @(state, x) begin
  case (state)
    0: z <= 0;
    1: z <= 1;
    2: z <= ~x;
    3: z <= ~x + 1;
  endcase
end

endmodule
