module top_module (
input [99:0] in,
output [98:0] out_both,
output [99:1] out_any,
output [99:0] out_different
);

  reg [98:0] temp_both;
  reg [99:1] temp_any;
  reg [99:0] temp_different;

  always @* begin
    // Calculate out_both
    for (int i = 0; i < 99; i = i+1) begin
      if (in[i] && in[i+1])
        temp_both[i] = 1;
      else
        temp_both[i] = 0;
    end

    // Calculate out_any
    for (int i = 1; i < 100; i = i+1) begin
      if (in[i] || in[i-1])
        temp_any[i] = 1;
      else
        temp_any[i] = 0;
    end

    // Calculate out_different
    for (int i = 0; i < 100; i = i+1) begin
      if (in[i] != in[(i-1+100)%100])
        temp_different[i] = 1;
      else
        temp_different[i] = 0;
    end
  end

  assign out_both = temp_both;
  assign out_any = temp_any;
  assign out_different = temp_different;

endmodule
