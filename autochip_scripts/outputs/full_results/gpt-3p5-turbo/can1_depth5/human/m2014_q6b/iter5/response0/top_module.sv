module top_module(
  input [3:1] y,
  input w,
  output reg [2:0] Y2);

  // Flip-flop declarations
  reg [3:1] y_reg;
  reg [3:1] y_next;
  
  // Next-state logic
  always @(*) begin
    case (y)
      3'b000:
        y_next = (w) ? 3'b000 : 3'b001;
      3'b001:
        y_next = (w) ? 3'b010 : 3'b011;
      3'b010:
        y_next = (w) ? 3'b100 : 3'b011;
      3'b011:
        y_next = (w) ? 3'b101 : 3'b100;
      3'b100:
        y_next = (w) ? 3'b100 : 3'b101;
      3'b101:
        y_next = (w) ? 3'b010 : 3'b011;
      default:
        y_next = 3'b000;
    endcase
  end
  
  // Reg update
  always @(posedge w) begin
    y_reg <= y_next;
  end
  
  // Output assignment
  always @(*) begin
    Y2 = y_reg[2:0];
  end
  
endmodule
