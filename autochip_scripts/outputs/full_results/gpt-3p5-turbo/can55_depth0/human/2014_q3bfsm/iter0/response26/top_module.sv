module top_module (
	input clk,
	input reset,
	input x,
	output reg z,
	output reg [2:0] y
);

  reg [2:0] y_next;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      y <= 3'b000;
      z <= 1'b0;
    end else begin
      y <= y_next;
      z <= (y == 3'b011) ? 1'b1 : 1'b0;
    end
  end
  
  always @(*) begin
    case (y)
      3'b000: y_next = (x) ? 3'b001 : 3'b000;
      3'b001: y_next = (x) ? 3'b100 : 3'b001;
      3'b010: y_next = (x) ? 3'b001 : 3'b010;
      3'b011: y_next = (x) ? 3'b010 : 3'b001;
      3'b100: y_next = (x) ? 3'b100 : 3'b011;
      default: y_next = 3'b000;
    endcase
  end
  
endmodule
