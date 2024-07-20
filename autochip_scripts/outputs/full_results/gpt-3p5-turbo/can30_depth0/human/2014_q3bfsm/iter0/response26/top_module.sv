module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

reg [2:0] y, y_next;

always @(posedge clk or posedge reset) begin
  if (reset)
    y <= 3'b000;
  else
    y <= y_next;
end

always @(y or x) begin
  case (y)
    3'b000:
      begin
        if (x)
          begin
            y_next = 3'b001;
            z = 1'b0;
          end
        else
          begin
            y_next = 3'b000;
            z = 1'b0;
          end
      end
    3'b001:
      begin
        if (x)
          begin
            y_next = 3'b100;
            z = 1'b0;
          end
        else
          begin
            y_next = 3'b001;
            z = 1'b0;
          end
      end
    3'b010:
      begin
        if (x)
          begin
            y_next = 3'b001;
            z = 1'b0;
          end
        else
          begin
            y_next = 3'b010;
            z = 1'b0;
          end
      end
    3'b011:
      begin
        if (x)
          begin
            y_next = 3'b010;
            z = 1'b1;
          end
        else
          begin
            y_next = 3'b001;
            z = 1'b0;
          end
      end
    3'b100:
      begin
        if (x)
          begin
            y_next = 3'b100;
            z = 1'b1;
          end
        else
          begin
            y_next = 3'b011;
            z = 1'b0;
          end
      end
    default:
      begin
        y_next = 3'b000;
        z = 1'b0;
      end
  endcase
end

endmodule
