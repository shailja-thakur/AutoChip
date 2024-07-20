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
  
  reg [1:0] state;
  
  // Outputs
  assign g[1] = (state == B || state == C);
  assign g[2] = (state == C);
  assign g[3] = (state == D);
  
  // State flip-flops
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      state <= A;
    end else begin
      case (state)
        A: begin
          if (r[1] && ~r[2] && ~r[3]) begin
            state <= A;
          end else if (r[1]) begin
            state <= B;
          end else if (~r[1] && r[2]) begin
            state <= C;
          end else if (~r[1] && ~r[2] && ~r[3]) begin
            state <= D;
          end
        end
        B: begin
          if (r[1]) begin
            state <= B;
          end else begin
            state <= A;
          end
        end
        C: begin
          if (r[2]) begin
            state <= C;
          end else begin
            state <= A;
          end
        end
        D: begin
          if (r[1] || r[2] || r[3]) begin
            state <= A;
          end
        end
      endcase
    end
  end
  
endmodule
