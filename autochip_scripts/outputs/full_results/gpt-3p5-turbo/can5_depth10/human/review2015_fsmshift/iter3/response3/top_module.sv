module top_module(
  input clk,
  input reset,
  output wire shift_ena
);

reg [3:0] count;
reg [3:0] enable;

always @(posedge clk) begin
  if (reset) begin
    count <= 4'b0;
    enable <= 4'b1111;
  end else begin
    if (count < 4'b1000) begin
      count <= count + 1'b1;
      enable <= 4'b1111;
    end else begin
      count <= 4'b0;
      enable <= 4'b0000;
    end
  end
end

assign shift_ena = enable[0];

endmodule
