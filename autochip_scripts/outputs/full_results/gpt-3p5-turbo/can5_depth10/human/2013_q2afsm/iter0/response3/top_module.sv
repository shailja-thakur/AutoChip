module top_module (
  input clk,
  input resetn,
  input [2:0] r,
  output [2:0] g
);

// State codes
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

// State register
reg [2:0] state, next_state;

// Outputs
assign g[1] = (state == B) ? 1'b1 : 1'b0;
assign g[2] = (state == C) ? 1'b1 : 1'b0;
assign g[3] = (state == D && (r[1] == 1'b0 && r[2] == 1'b0)) ? 1'b1 : 1'b0;

// Next-state logic
always @(posedge clk or negedge resetn) begin
  if (~resetn) begin
    state <= A;
  end else begin
    state <= next_state;
  end
end

// State transition logic
always @(state, r) begin
  case (state)
    A: begin
      if (r[1] && ~r[2]) begin
        next_state = B;
      end else if (~r[1] && r[2]) begin
        next_state = C;
      end else if (~r[1] && ~r[2] && ~r[3]) begin
        next_state = D;
      end else begin
        next_state = A;
      end
    end
    B: begin
      if (~r[1]) begin
        next_state = A;
      end else begin
        next_state = B;
      end
    end
    C: begin
      if (~r[2]) begin
        next_state = A;
      end else begin
        next_state = C;
      end
    end
    D: begin
      if (r[1] || r[2] || r[3]) begin
        next_state = A;
      end else begin
        next_state = D;
      end
    end
  endcase
end

endmodule
