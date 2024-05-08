module top_module ( input clk, input d, output q );

  my_dff my_dff1 ( clk, d, q[0] );
  my_dff my_dff2 ( clk, q[0], q[1] );
  my_dff my_dff3 ( clk, q[1], q[2] );

endmodule