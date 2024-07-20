module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q);
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      q <= 4'b0000; //reset the output register to 0
    end
    else begin
      if (load) begin
        q <= data; //load data input into the output register
      end
      else begin
        if (ena) begin
          q <= {q[2:0], q[3]}; //shift left by 1 bit
        end
      end
    end
  end

endmodule
