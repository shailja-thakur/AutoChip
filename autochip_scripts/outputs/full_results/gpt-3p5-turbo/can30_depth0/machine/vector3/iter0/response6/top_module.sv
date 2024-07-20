module top_module (
  input [4:0] a,
  input [4:0] b,
  input [4:0] c,
  input [4:0] d,
  input [4:0] e,
  input [4:0] f,
  output [7:0] w,
  output [7:0] x,
  output [7:0] y,
  output [7:0] z
);
  
  reg [7:0] conc; // concatenation signal
  
  always @* begin
    conc = {a, b, c, d, e, f, 2'b11};
    w = conc[7:0];
    x = conc[15:8]; 
    y = conc[23:16]; 
    z = conc[31:24];
  end

endmodule
