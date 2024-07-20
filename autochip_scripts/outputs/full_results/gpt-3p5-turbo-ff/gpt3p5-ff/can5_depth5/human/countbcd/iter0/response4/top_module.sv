module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);

  reg [3:0] ones_digit;
  reg [3:0] tens_digit;
  reg [3:0] hundreds_digit;
  reg [3:0] thousands_digit;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      ones_digit <= 4'b0;
      tens_digit <= 4'b0;
      hundreds_digit <= 4'b0;
      thousands_digit <= 4'b0;
    end else begin
      if (ena[3]) begin
        if (ones_digit == 9) begin
          ones_digit <= 4'b0;
          if (ena[2]) begin
            if (tens_digit == 9) begin
              tens_digit <= 4'b0;
              if (ena[1]) begin
                if (hundreds_digit == 9) begin
                  hundreds_digit <= 4'b0;
                  if (ena[0]) begin
                    if (thousands_digit == 9) begin
                      thousands_digit <= 4'b0;
                    end else begin
                      thousands_digit <= thousands_digit + 1;
                    end
                  end
                end else begin
                  hundreds_digit <= hundreds_digit + 1;
                end
              end
            end else begin
              tens_digit <= tens_digit + 1;
            end
          end
        end else begin
          ones_digit <= ones_digit + 1;
        end
      end
    end
  end

  assign q = {thousands_digit, hundreds_digit, tens_digit, ones_digit};
endmodule
