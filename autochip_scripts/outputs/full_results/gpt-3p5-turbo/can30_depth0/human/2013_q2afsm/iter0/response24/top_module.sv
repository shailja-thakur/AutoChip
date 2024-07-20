module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

  // State enumeration
  parameter A = 2'd0;
  parameter B = 2'd1;
  parameter C = 2'd2;
  parameter D = 2'd3;

  // State register
  reg [1:0] state;

  always @(posedge clk or negedge resetn)
  begin
    if (!resetn)
      state <= A;
    else
    begin
      case(state)
        A: if(r[1]) state <= B;
           else if(r[2]) state <= C;
           else if(r[3]) state <= D;
        B: if(r[1]) state <= B;
           else state <= A;
        C: if(r[2]) state <= C;
           else state <= A;
        D: if(r[1] || r[2] || r[3]) state <= D;
           else state <= A;
      endcase
    end
  end

  // FSM outputs
  assign g[1] = (state == D && (!r[1] && !r[2] && !r[3])) ? 1'b1 : 1'b0;
  assign g[2] = (state == C && (!r[1] && !r[2] && !r[3])) ? 1'b1 : 1'b0;
  assign g[3] = (state == B && (!r[1] && !r[2] && !r[3])) ? 1'b1 : 1'b0;

endmodule
