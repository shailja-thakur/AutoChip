module top_module(
  input clk,
  input reset,
  output reg shift_ena
);

reg [3:0] count;
reg enable;

always @(posedge clk) begin
  if (reset) begin
    count <= 4'b0;
    enable <= 1'b1;
    shift_ena <= 1'b1;
  end else begin
    if (count < 4'b1000) begin
      count <= count + 1'b1;
    end else begin
      count <= 4'b0;
      enable <= 1'b0;
      shift_ena <= 1'b0;
    end
  end
end

endmodule
