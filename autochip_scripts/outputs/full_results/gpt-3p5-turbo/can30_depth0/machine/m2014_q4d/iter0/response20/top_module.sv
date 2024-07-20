module top_module (
  input clk,
  input in,
  output logic out
);
// Define the flip-flop state variable
logic state;

// On posedge of clk, toggle the output
always_ff @(posedge clk) begin
  out <= state ^ in;
  state <= out;
end
endmodule
