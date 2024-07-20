module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define reg variables
reg [1:0] state_reg, state_next;
reg [2:0] g_reg, g_next;

// State table
always @(posedge clk or negedge resetn) begin
  if (~resetn) begin
    state_reg <= A;
    g_reg <= 3'b000;
  end
  else begin
    state_reg <= state_next;
    g_reg <= g_next;
  end
end

// State flip-flops
always @(state_reg, r) begin
  case (state_reg)
    A: begin
      if (r[1] & (~r[2]) & (~r[3]))
        state_next = A;
      else if (r[1])
        state_next = B;
      else if (~r[1] & r[2])
        state_next = C;
      else if (~r[1] & (~r[2]) & (~r[3]))
        state_next = D;
    end
    B: begin
      if (g_reg[1])
        state_next = B;
      else if (r[1])
        state_next = B;
      else if (~r[1])
        state_next = A;
    end
    C: begin
      if (g_reg[2])
        state_next = C;
      else if (r[2])
        state_next = C;
      else if (~r[2])
        state_next = A;
    end
    D: begin
      if (r[1] & (~r[2]) & (~r[3]))
        state_next = D;
      else if (r[1])
        state_next = B;
      else if (~r[1] & r[2])
        state_next = C;
      else if (~r1 & (~r2) & (~r3))
        state_next = D;
    end
  endcase
end

// FSM outputs
always @(state_reg) begin
  case (state_reg)
    A: begin
      g_next[1] = (~r[1]) & (~r[2]) & (~r[3]);
      g_next[2] = r[1] & (~r[2]) & (~r[3]);
      g_next[3] = r[1] & (~r[2]) & (~r[3]);
    end
    B: begin
      g_next[1] = g_reg[1];
      g_next[2] = r[2];
      g_next[3] = r[2];
    end
    C: begin
      g_next[1] = r[1];
      g_next[2] = g_reg[2];
      g_next[3] = r[2];
    end
    D: begin
      g_next[1] = g_reg[1];
      g_next[2] = g_reg[2];
      g_next[3] = (~r[1]) & (~r[2]) & (~r[3]);
    end
  endcase
end

// Output assignment
assign g = g_reg;

endmodule
