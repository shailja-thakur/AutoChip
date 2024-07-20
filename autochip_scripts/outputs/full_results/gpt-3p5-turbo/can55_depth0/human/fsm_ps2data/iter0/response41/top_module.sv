module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

reg [7:0] counter;
reg [23:0] temp_bytes;

always @(posedge clk) begin
  if (reset) begin
    counter <= 0;
    temp_bytes <= 0;
    done <= 0;
    out_bytes <= 0;
  end
  else begin
    if (counter == 0 && in[3] == 1) begin
      counter <= 1;
      temp_bytes[23:16] <= in;
    end
    else if (counter == 1) begin
      counter <= 2;
      temp_bytes[15:8] <= in;
    end
    else if (counter == 2) begin
      counter <= 0;
      counter <= 0;
      temp_bytes[7:0] <= in;
      out_bytes <= temp_bytes;
      done <= 1;
    end
    else begin
      counter <= 0;
    end
  end
end

endmodule
