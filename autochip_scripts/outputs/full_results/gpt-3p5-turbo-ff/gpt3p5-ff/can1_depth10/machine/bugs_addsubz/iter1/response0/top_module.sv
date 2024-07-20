module top_module (
  input wire do_sub,
  input wire [7:0] a,
  input wire [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);

always @(do_sub, a, b) begin
  case(do_sub)
    0: begin
      out <= a + b;
      if(out == 0) begin
        result_is_zero <= 1;
      end
      else begin
        result_is_zero <= 0;
      end
    end

    1: begin
      out <= a - b;
      if(out == 0) begin
        result_is_zero <= 1;
      end
      else begin
        result_is_zero <= 0;
      end
    end

    default: begin
      out <= 8'b0;
      result_is_zero <= 1'b0;
    end
  end
end

endmodule
