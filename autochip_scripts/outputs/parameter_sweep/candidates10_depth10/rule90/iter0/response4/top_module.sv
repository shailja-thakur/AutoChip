module rule90_cell(
  input left,
  input center,
  input right,
  output reg next_state
);
  
  always @*
  begin
    case({left, center, right})
      3'b111: next_state = 1'b0;
      3'b110: next_state = 1'b1;
      3'b101: next_state = 1'b0;
      3'b100: next_state = 1'b1;
      3'b011: next_state = 1'b1;
      3'b010: next_state = 1'b0;
      3'b001: next_state = 1'b1;
      3'b000: next_state = 1'b0;
    endcase
  end
endmodule
module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
  
  reg [511:0] next_state;
  
  always @(posedge clk)
  begin
    if (load)
      q <= data;
    else
      q <= next_state;
  end
  
  genvar i;
  generate
    for (i = 0; i < 512; i=i+1)
    begin: cells
      rule90_cell cell(
        q[(i-1+512) % 512],
        q[i],
        q[(i+1) % 512],
        next_state[i]
      );
    end
  endgenerate

endmodule
