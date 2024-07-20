module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

reg [7:0] in_reg1;
reg [7:0] in_reg2;
reg [7:0] in_reg3;
reg receive_start;

always @(posedge clk or posedge reset) begin
  if (reset)
    in_reg1 <= 8'b0;
  else
    in_reg1 <= in;
end

always @(posedge clk or posedge reset) begin
  if (reset)
    in_reg2 <= 8'b0;
  else
    in_reg2 <= in_reg1;
end

always @(posedge clk or posedge reset) begin
  if (reset)
    in_reg3 <= 8'b0;
  else
    in_reg3 <= in_reg2;
end

always @(posedge clk) begin
  if (reset)
    receive_start <= 1'b0;
  else if (!receive_start && in_reg1[3])
    receive_start <= 1'b1;
  else if (!in_reg2[3])
    receive_start <= 1'b0;
end

always @(posedge clk) begin
  if (reset)
    done <= 1'b0;
  else if (receive_start && in_reg1[3] && in_reg2[3])
    done <= 1'b1;
  else
    done <= 1'b0;
end

endmodule
