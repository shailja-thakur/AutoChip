module top_module(
  input clk,
  input reset,
  output reg shift_ena
);

reg [3:0] count;
reg reset_done;

always @(posedge clk) begin
  if (reset) begin
    count <= 4'b0;
    shift_ena <= 1'b0;
    reset_done <= 1'b0;
  end else begin
    if (reset_done == 1'b0) begin
      count <= count + 1'b1;
      if (count < 4'b1000) begin
        shift_ena <= 1'b1;
      end else begin
        shift_ena <= 1'b0;
        reset_done <= 1'b1;
      end
    end else begin
      shift_ena <= 1'b0;
    end
  end
end

endmodule
