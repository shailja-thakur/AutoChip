module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);

// Internal wires
wire [511:0] q_next;

// Register for holding the current state of the system
always @(posedge clk) begin
  if (load) begin
    q <= data;
  end else begin
    q <= q_next;
  end
end

// Combinational logic for computing the next state of each cell
generate
  for (int i = 0; i < 512; i = i + 1) begin : cell_update
    assign q_next[i] = (i == 0 ? 0 : q[i-1]) ^ q[i] ^ (i == 511 ? 0 : q[i+1]);
  end
endgenerate

endmodule
