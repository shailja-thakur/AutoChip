module top_module (
  input clk,
  input resetn,
  input [2:0] r,
  output [2:0] g
);

  // State Enumerator
  parameter A = 3'b000;
  parameter B = 3'b001;
  parameter C = 3'b010;
  parameter D = 3'b011;

  // State flip-flops
  reg [2:0] current_state, next_state;

  // Output signals
  assign g[2] = (current_state == A && r[2] == 1) ? 1'b1 : 1'b0;
  assign g[1] = (current_state == A && r[1] == 1) ? 1'b1 : (current_state == B && r[1] == 1 && r[0] == 1) ? 1'b1 : 1'b0;
  assign g[0] = (current_state == A && r[0] == 1 && r[1] == 0 && r[2] == 0) ? 1'b1 : (current_state == C && r[0] == 1 && r[1] == 0) ? 1'b1 : 1'b0;

  // State table
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      current_state <= A;
    end else begin
      current_state <= next_state;
    end
  end

  always @(current_state or r) begin
    case(current_state)
      A: begin
        if (r[2] == 1) begin
          next_state = A;
        end else if (r[1] == 1) begin
          next_state = B;
        end else if (r[0] == 1) begin
          next_state = C;
        end else begin
          next_state = D;
        end
      end

      B: begin
        if (r[1] == 1 && r[0] == 1) begin
          next_state = B;
        end else if (r[1] == 1 && r[0] == 0) begin
          next_state = A;
        end else begin
          next_state = D;
        end
      end

      C: begin
        if (r[0] == 1 && r[1] == 0) begin
          next_state = C;
        end else if (r[0] == 1 && r[1] == 1) begin
          next_state = A;
        end else begin
          next_state = D;
        end
      end

      D: begin
        next_state = A;
      end
    endcase
  end

endmodule
