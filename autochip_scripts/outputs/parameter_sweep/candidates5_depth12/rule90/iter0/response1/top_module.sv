module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  // Internal wire to hold the next state values
  wire [511:0] q_next;

  // Assign default values to the boundary cells
  assign q_next[511] = 0;
  assign q_next[0] = 0;

  // Define the rule 90 logic for the rest of the cells
  // Loop through each cell from index 1 to index 510
  genvar i;
  generate
    for (i = 1; i < 511; i = i + 1) begin: RULE90
      assign q_next[i] = data[i-1] ^ data[i+1];
    end
  endgenerate

  // Synchronous logic for updating the state
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= q_next;
    end
  end

endmodule
