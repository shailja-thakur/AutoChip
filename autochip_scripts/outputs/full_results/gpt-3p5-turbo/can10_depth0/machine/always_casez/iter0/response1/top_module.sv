module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

  always @* begin
    casez(in)
      8'bzzzzzz01: pos = 3'h0;
      8'bzzzzz10x: pos = 3'h1;
      8'bzzzzz110: pos = 3'h2;
      8'bzzzz1zzz: pos = 3'h3;
      8'bzzzz011x: pos = 3'h4;
      8'bzzzz100x: pos = 3'h5;
      8'bzz1zzzz: pos = 3'h6;
      8'bzz011zz: pos = 3'h7;
      default: pos = 3'h0;
    endcase
  end

endmodule
