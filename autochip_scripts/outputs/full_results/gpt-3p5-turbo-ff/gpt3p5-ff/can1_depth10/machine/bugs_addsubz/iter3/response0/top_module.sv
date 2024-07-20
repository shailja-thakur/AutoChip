module top_module (
  input wire do_sub,
  input wire [7:0] a,
  input wire [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);

always @* begin
  case(do_sub)
    1'b0: begin
      out = a + b;
    end

    1'b1: begin
      out = a - b;
    end
  end
  
  if (out == 8'b0) begin
    result_is_zero = 1'b1;
  end
  else begin
    result_is_zero = 1'b0;
  end
end

endmodule
