module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  reg [1:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b01; // initial state B
    end else if (state == 2'b01) begin // state B
      state <= in ? 2'b01 : 2'b10; // next state B or A
    end else if (state == 2'b10) begin // state A
      state <= in ? 2'b10 : 2'b01; // next state A or B
    end
  end
  
  assign out = (state == 2'b10) ? 1'b1 : 1'b0; // out is high if state is B, else low
  
endmodule
