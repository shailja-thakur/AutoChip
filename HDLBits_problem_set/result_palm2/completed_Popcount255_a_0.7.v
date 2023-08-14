module top_module (
  input wire [254:0] in,
  output reg [7:0] out
);

  reg [254:0] count;

  always @(posedge clk) begin
    if (reset) begin
      count <= 0;
    end else begin
      for (int i = 0; i < 255; i++) begin
        count[i] <= count[i] + (in[i] == 1);
      end
    end
  end

  assign out = count;

endmodule