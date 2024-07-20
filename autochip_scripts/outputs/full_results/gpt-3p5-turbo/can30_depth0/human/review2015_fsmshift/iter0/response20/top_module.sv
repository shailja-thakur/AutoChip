module top_module(
  input clk,
  input reset,
  output shift_ena);
  
  reg [3:0] count;
  reg shift_ena;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      count <= 4'd0;
      shift_ena <= 1'b1;
    end else begin
      if (count < 4'd3)
        count <= count + 4'd1;
      else begin
        count <= 4'd0;
        shift_ena <= 1'b0;
      end
    end
  end
endmodule
