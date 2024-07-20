module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

reg [7:0] Q;
wire [2:0] ABC;

DFFM #(1) D0 (clk, enable, Q[0], Q[0]); 
DFFM #(1) D1 (clk, enable, Q[1], Q[1]);
DFFM #(1) D2 (clk, enable, Q[2], Q[2]);
DFFM #(1) D3 (clk, enable, Q[3], Q[3]);
DFFM #(1) D4 (clk, enable, Q[4], Q[4]);
DFFM #(1) D5 (clk, enable, Q[5], Q[5]);
DFFM #(1) D6 (clk, enable, Q[6], Q[6]);
DFFM #(1) D7 (clk, enable, Q[7], Q[7]);

assign ABC = {A,B,C};

MUX3x1 MUX (
  .A0(Q[0]),
  .A1(Q[1]),
  .A2(Q[2]),
  .S(ABC[0]),
  .Z(Z)
);

mux3x1 MUX2 (
  .a0(Q[3]),
  .a1(Q[4]),
  .a2(Q[5]),
  .s(ABC[0]),
  .z(Z)
); 

mux3x1 MUX3 (
  .a0(Q[6]),
  .a1(Q[7]),
  .a2(Z),
  .s(ABC[0]),
  .z(Z)
);

always @(posedge clk) begin
  if (enable)
    Q[0] <= S;
  else begin
    Q[7] <= Q[6];
    Q[6] <= Q[5];
    Q[5] <= Q[4];
    Q[4] <= Q[3];
    Q[3] <= Q[2];
    Q[2] <= Q[1];
    Q[1] <= Q[0];
    Q[0] <= S;
  end
end

endmodule
