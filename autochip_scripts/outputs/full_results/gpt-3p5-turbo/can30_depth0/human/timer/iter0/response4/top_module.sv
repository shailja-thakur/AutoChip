module top_module(
  input wire clk,
  input wire load,
  input wire [9:0] data,
  output wire tc
);

  reg [9:0] counter;
  reg tc_temp;
  
  always @(posedge clk) begin
    if (load) begin
      counter <= data;
      tc_temp <= 0;
    end
    else begin
      if (counter == 0) begin
        tc_temp <= 1;
      end
      else begin
        counter <= counter - 1;
        tc_temp <= 0;
      end
    end
  end
  
  assign tc = tc_temp;
  
endmodule
