module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);

  reg [7:0] previous_in; // to store the previous input value

  always @(posedge clk) begin
    previous_in <= in;
  end

  always @(posedge clk) begin
    anyedge <= (in & ~previous_in); // detect 0 to 1 transition

    // set the output bit the cycle after a 0 to 1 transition
    anyedge <= anyedge | anyedge;
  end

endmodule
