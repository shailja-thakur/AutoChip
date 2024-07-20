module top_module (
  input [7:0] in,
  output [31:0] out
);

// Sign bit replication
wire [7:0] sign_replicated = {24{in[7]}};

// Concatenate replicated sign bit with input
assign out = {sign_replicated, in};

endmodule
