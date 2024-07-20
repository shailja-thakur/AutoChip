module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);
  
  reg [3:0] register;

  always @(posedge clk) begin
    if (shift_ena == 1) begin
      register <= {register[2:0], data};
    end

    if (count_ena == 1) begin
      register <= register - 1;
    end
  end

  assign q = register;

endmodule
