module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] y;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      y <= 3'b000;
    end else begin
      case(y)
        3'b000: if (x) begin y <= 3'b001; end else begin y <= 3'b000; end
        3'b001: if (x) begin y <= 3'b100; end else begin y <= 3'b001; end
        3'b010: if (x) begin y <= 3'b001; end else begin y <= 3'b010; end
        3'b011: if (x) begin y <= 3'b010; end else begin y <= 3'b001; end
        3'b100: if (x) begin y <= 3'b100; end else begin y <= 3'b011; end
      endcase
    end
  end
  
  always @(posedge clk) begin
    case(y)
      3'b111: z <= 1;
      default: z <= 0;
    endcase
  end

endmodule
