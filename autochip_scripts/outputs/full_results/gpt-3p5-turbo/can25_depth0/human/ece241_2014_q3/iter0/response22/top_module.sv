module top_module (
  input c,
  input d,
  output [3:0] mux_in
);

  wire [1:0] ab;
  
  // Implementing the truth table using if-else statements
  always @* begin
    if (c == 0 && d == 0) begin
      ab = 2'b00;
    end else if (c == 0 && d == 1) begin
      ab = 2'b01;
    end else if (c == 1 && d == 1) begin
      ab = 2'b11;
    end else begin
      ab = 2'b10;
    end
  end

  // Connecting the outputs of the top_module to the input mux_in of 4-to-1 multiplexer
  assign mux_in[0] = ab[0];
  assign mux_in[1] = ab[1];
  assign mux_in[2] = ab[1];
  assign mux_in[3] = ab[0];

endmodule
