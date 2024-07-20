module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg f;
reg g;
reg [2:0] state, next_state;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
        f <= 0;
        g <= 0;
    end else begin
        state <= next_state;
	      case (state)
	          A: begin
	              if (resetn == 0)
	                  next_state = A;
                  else
	                  next_state = B;
	          end
	          B: begin
	              f <= 1;
	              next_state = C;
	          end
	          C: begin
	              if (x == 1 && @(posedge clk) x == 0 && @(posedge clk) x == 1)
	                  next_state = D;
                  else
	                  next_state = C;
	          end
	          D: begin
	              if (y == 1)
	                  g <= 1;
	              else
	                  g <= 0;
	              next_state = D;
	          end
	      endcase
    end
end

endmodule
