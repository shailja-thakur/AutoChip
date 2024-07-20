module top_module (
  input [4:1] x,
  output logic f
);

reg [1:0] x_indices; // Internal signals to identify which indexes are valid in the K-map
reg [1:0] y_indices; // Internal signals to identify which indexes are valid in the K-map

always_comb begin
  x_indices[0] = ~x[3] & ~x[1];
  x_indices[1] = ~x[3] & x[1];
  x_indices[2] = x[3] & x[1];
  x_indices[3] = x[3] & ~x[1];

  y_indices[0] = ~x[4] & ~x[2];
  y_indices[1] = ~x[4] & x[2];
  y_indices[2] = x[4] & x[2];
  y_indices[3] = x[4] & ~x[2];

  case ({x_indices, y_indices})
    4'b0000: f = 1'b0;
    4'b0001: f = 1'b0;
    4'b0010: f = 1'b0;
    4'b0011: f = 1'b0;
    4'b0100: f = 1'b0;
    4'b0101: f = 1'b0;
    4'b0110: f = 1'b0;
    4'b0111: f = 1'b1;
    4'b1000: f = 1'b1;
    4'b1001: f = 1'b0;
    4'b1010: f = 1'b1;
    4'b1011: f = 1'b0;
    4'b1100: f = 1'b1;
    4'b1101: f = 1'b1;
    4'b1110: f = 1'b0;
    4'b1111: f = 1'b0;
  endcase
end

endmodule
