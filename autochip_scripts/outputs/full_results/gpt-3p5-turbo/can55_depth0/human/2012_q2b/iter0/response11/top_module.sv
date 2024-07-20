module top_module (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

reg [5:0] next_state;
reg [5:0] current_state;

parameter A = 6'b000001;
parameter B = 6'b000010;
parameter C = 6'b000100;
parameter D = 6'b001000;
parameter E = 6'b010000;
parameter F = 6'b100000;

always @(posedge w) begin
  current_state <= next_state;
  
  case (current_state)
    A: begin
      if (y[0])
        next_state = B;
      else
        next_state = A;
      end
    B: begin
      if (y[0])
        next_state = C;
      else
        next_state = D;
      end
    C: begin
      if (y[0])
        next_state = E;
      else
        next_state = D;
      end
    D: begin
      if (y[0])
        next_state = F;
      else
        next_state = A;
      end
    E: begin
      if (y[1])
        next_state = E;
      else
        next_state = D;
      end
    F: begin
      if (y[1])
        next_state = C;
      else
        next_state = D;
      end
  endcase
  
end

assign Y1 = next_state[1];
assign Y3 = next_state[3];

endmodule
