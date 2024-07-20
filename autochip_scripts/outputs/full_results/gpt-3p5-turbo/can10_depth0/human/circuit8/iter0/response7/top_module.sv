module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
  
  reg [1:0] state;
  
  always @(posedge clock) begin
    case(state)
      0: begin
        p <= 0;
        q <= 0;
        if(a) begin
          state <= 1;
        end
      end
      1: begin
        p <= a;
        if(~a) begin
          state <= 2;
        end
      end
      2: begin
        q <= 1;
        if(a) begin
          state <= 0;
        end
      end
    endcase
  end
  
endmodule
