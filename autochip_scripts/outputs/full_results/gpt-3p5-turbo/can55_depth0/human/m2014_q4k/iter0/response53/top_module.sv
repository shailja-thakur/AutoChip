module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

  reg [3:0] registers;
  wire [3:0] next_registers;

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      registers <= 4'b0;
    else
      registers <= next_registers;
  end

  assign out = registers[0];

  always @(*) begin
    next_registers[0] = in;
    next_registers[1] = registers[0];
    next_registers[2] = registers[1];
    next_registers[3] = registers[2];
  end

endmodule
