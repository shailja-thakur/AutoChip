module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

reg [3:1] state;
reg [3:1] next_state;

always @(posedge clk) begin
  if (!resetn)
    state <= 3'b001;
  else
    state <= next_state;
end

always @(*) begin
  case (state)
    3'b001: begin
      if (r[1]) next_state = 3'b010;
      else if (r[2]) next_state = 3'b011;
      else if (r[3]) next_state = 3'b100;
      else next_state = 3'b001;
    end
    3'b010: begin
      if (r[1]) next_state = 3'b010;
      else next_state = 3'b001;
    end
    3'b011: begin
      if (r[2]) next_state = 3'b011;
      else next_state = 3'b001;
    end
    3'b100: begin
      if (r[3]) next_state = 3'b100;
      else next_state = 3'b001;
    end
  endcase
end

assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0;
assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0;
assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0;

endmodule
