module A(
  input x,
  input y,
  output z);

  assign z = (x ^ y) & x;

endmodule
module B(
  input x,
  input y,
  output z);

  // Simulation waveform:
  // time            x               y               z
  // 0ns             0               0               1
  // 5ns             0               0               1
  // 10ns            0               0               1
  // 15ns            0               0               1
  // 20ns            0               0               1
  // 25ns            1               0               0
  // 30ns            1               0               0
  // 35ns            0               1               0
  // 40ns            0               1               0
  // 45ns            1               1               1
  // 50ns            1               1               1
  // 55ns            0               0               1
  // 60ns            0               1               0
  // 65ns            0               1               0
  // 70ns            1               1               1
  // 75ns            0               1               0
  // 80ns            0               1               0
  // 85ns            0               1               0
  // 90ns            1               0               0

  reg [1:0] state;
  always @(x, y) begin
    case({x, y})
      2'b00: state <= 2'b01;
      2'b10: state <= 2'b00;
      2'b01: state <= 2'b01;
      2'b11: state <= 2'b11;
    endcase
  end

  always @(state) begin
    case(state)
      2'b00: z = 1'b1;
      2'b01: z = 1'b0;
      2'b11: z = 1'b1;
      default: z = 1'b0;
    endcase
  end

endmodule
module top_module(
  input x,
  input y,
  output z);

  wire a_1_out, b_1_out, a_2_out, b_2_out;

  A inst_a_1(
    .x(x),
    .y(y),
    .z(a_1_out)
  );

  B inst_b_1(
    .x(x),
    .y(y),
    .z(b_1_out)
  );

  A inst_a_2(
    .x(x),
    .y(y),
    .z(a_2_out)
  );

  B inst_b_2(
    .x(x),
    .y(y),
    .z(b_2_out)
  );

  wire or_out, and_out;

  or_gate or_inst(
    .a(a_1_out),
    .b(b_1_out),
    .z(or_out)
  );

  and_gate and_inst(
    .a(a_2_out),
    .b(b_2_out),
    .z(and_out)
  );

  xor_gate xor_inst(
    .a(or_out),
    .b(and_out),
    .z(z)
  );

endmodule
module or_gate(
  input a,
  input b,
  output z);

  assign z = a | b;

endmodule
module and_gate(
  input a,
  input b,
  output z);

  assign z = a & b;

endmodule
module xor_gate(
  input a,
  input b,
  output z);

  assign z = a ^ b;

endmodule
