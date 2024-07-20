module top_module (
  input clk,
  input a,
  output reg q
);
  
  always @(posedge clk) begin
    case (q)
      1: begin
        if (a == 0) begin
          q <= 0;
        end
      end
      0: begin
        if (a == 1) begin
          q <= 1;
        end
      end
    endcase
  end
  
endmodule
