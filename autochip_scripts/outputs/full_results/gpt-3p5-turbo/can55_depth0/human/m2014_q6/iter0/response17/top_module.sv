module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  reg [2:0] state;
  
  always @(posedge clk, posedge reset) begin
    if (reset)
      state <= 3'b000; // initial state A
    else if (w) begin
      case(state)
        3'b000: state <= 3'b001; // state A -> state B on w = 1
        3'b001: state <= 3'b000; // state A -> state A on w = 0
        3'b010: state <= 3'b100; // state B -> state C on w = 0
        3'b011: state <= 3'b101; // state B -> state D on w = 1
        3'b100: state <= 3'b110; // state C -> state E on w = 0
        3'b101: state <= 3'b101; // state C -> state D on w = 1
        3'b110: state <= 3'b111; // state D -> state F on w = 0
        3'b111: state <= 3'b000; // state D -> state A on w = 1
      endcase
    end
  end
  
  assign z = (state == 3'b011 || state == 3'b101 || state == 3'b110 || state == 3'b111) ? 1'b1 : 1'b0;
  
endmodule
