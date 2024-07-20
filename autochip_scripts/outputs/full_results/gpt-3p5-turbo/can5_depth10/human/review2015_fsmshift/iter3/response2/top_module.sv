module top_module(
  input clk,
  input reset,
  output wire shift_ena
);

reg [1:0] count;
reg enable;

always @(posedge clk) begin
  if (reset) begin
    count <= 2'b0;
    enable <= 1'b1;
  end else begin
    if (count < 2'b11) begin
      count <= count + 1'b1;
    end else begin
      count <= 2'b0;
      enable <= 1'b0;
    end
  end
end

assign shift_ena = enable;

endmodule
