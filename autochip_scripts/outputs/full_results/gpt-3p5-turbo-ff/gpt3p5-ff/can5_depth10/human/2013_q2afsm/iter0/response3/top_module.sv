module top_module (
  input clk,
  input resetn,
  input [2:0] r,
  output [2:0] g
);

  // State codes
  localparam A = 3'b000;
  localparam B = 3'b001;
  localparam C = 3'b010;
  localparam D = 3'b011;

  // State registers
  reg [2:0] current_state;
  reg [2:0] next_state;

  // Output assignments
  assign g[2] = (current_state == D) ? 1'b1 : 1'b0;
  assign g[1] = (current_state == B || current_state == C) ? 1'b1 : 1'b0;
  assign g[0] = (current_state == C) ? 1'b1 : 1'b0;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      current_state <= A;
    end else begin
      current_state <= next_state;
    end
  end
  
  always @(*) begin
    case (current_state)
      A: begin
        if (r[2] == 1'b1) begin
          next_state = C;
        end else if (r[1] == 1'b1) begin
          next_state = B;
        end else if (r[0] == 1'b1) begin
          next_state = D;
        end else begin
          next_state = A;
        end
      end
      
      B: begin
        if (r[1] == 1'b1) begin
          next_state = B;
        end else begin
          next_state = A;
        end
      end
      
      C: begin
        if (r[0] == 1'b1) begin
          next_state = C;
        end else begin
          next_state = A;
        end
      end
      
      D: begin
        next_state = A;
      end
    endcase
  end
endmodule
