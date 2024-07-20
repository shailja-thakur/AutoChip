module top_module(
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg Q
);

  reg [2:0] r;
  wire [2:0] q;
  wire [1:0] mux_out;

  // Instantiate submodule 1
  flipflop u1(
    .clk(clk),
    .D(r[0]),
    .Q(q[0])
  );

  // Instantiate submodule 2
  flipflop u2(
    .clk(clk),
    .D(r[1]),
    .Q(q[1])
  );

  // Instantiate submodule 3
  mux_2to1 u3(
    .A(q[0]),
    .B(r_in),
    .S(L),
    .Y(mux_out[0])
  );

  always @(posedge clk) begin
    r[0] <= q_in;
    r[1] <= mux_out[0];
    
    if (L) begin
      Q <= r_in;
    end else begin
      Q <= {Q[1] ^ Q[2], Q[0], Q[2]};
    end
  end
endmodule
module flipflop(
  input clk,
  input D,
  output reg Q
);
  always @(posedge clk) begin
    Q <= D;
  end
endmodule
module mux_2to1(
  input A,
  input B,
  input S,
  output reg Y
);
  always @(*) begin
    if (S)
      Y <= B;
    else
      Y <= A;
  end
endmodule
