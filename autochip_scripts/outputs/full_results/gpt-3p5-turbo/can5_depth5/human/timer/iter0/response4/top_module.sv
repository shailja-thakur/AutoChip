module top_module(
  input clk,
  input load,
  input [9:0] data,
  output tc
);

reg [9:0] count;
reg tc;

always @(posedge clk) begin
  if(load == 1) begin
    count <= data;
    tc <= 0;
  end else begin
    if(count > 0) begin
      count <= count - 1;
      tc <= 0;
    end else begin
      tc <= 1;
    end
  end
end

endmodule
