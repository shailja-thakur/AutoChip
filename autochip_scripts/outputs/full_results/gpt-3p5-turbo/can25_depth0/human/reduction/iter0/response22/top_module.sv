module top_module (
  input [7:0] in,
  output parity
);

  wire [7:0] xor_in;
  wire xor_out;

  assign xor_in = in;
  assign xor_out = xor(xor_in);

  assign parity = xor_out;
  
  // XOR gate implementation
  function xor;
    input [7:0] data;
    reg out;
    integer i;

    begin
      out = 0;
      for (i = 0; i < 8; i = i + 1) begin
        out = out ^ data[i];
      end
      xor = out;
    end
  endfunction

endmodule
