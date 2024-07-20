module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
 
  reg [2:0] state, next_state;
  reg g1, g2, g3;
 
  localparam A = 3'b000;
  localparam B = 3'b001;
  localparam C = 3'b010;
  localparam D = 3'b011;
 
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      state <= A;
    else
      state <= next_state;
  end
 
  always @(state, r) begin
    case (state)
      A: begin
        if (r[1] == 1) begin
          next_state = B;
          g1 = 1'b1;
        end else if (r[2] == 1) begin
          next_state = C;
          g2 = 1'b1;
        end else if (r[3] == 1) begin
          next_state = D;
          g3 = 1'b1;
        end else begin
          next_state = A;
        end
      end
      B: begin
        if (r[1] == 1) begin
          next_state = B;
          g1 = 1'b1;
        end else begin
          next_state = A;
        end
      end
      C: begin
        if (r[2] == 1) begin
          next_state = C;
          g2 = 1'b1;
        end else begin
          next_state = A;
        end
      end
      D: begin
        next_state = A;
      end
    endcase
  end
 
  always @(posedge clk) begin
    g[1] <= g1;
    g[2] <= g2;
    g[3] <= g3;
  end
 
endmodule
