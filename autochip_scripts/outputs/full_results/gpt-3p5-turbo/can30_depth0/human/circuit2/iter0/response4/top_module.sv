module top_module (
  input a,
  input b,
  input c,
  input d,
  output reg q
);

  always @* begin
    if (a) begin
      if (b) begin
        if (c) begin
          if (d) begin
            q = 1'b1;
          end
          else begin
            q = 1'b0;
          end
        end
        else begin
          if (d) begin
            q = 1'b0;
          end
          else begin
            q = 1'b1;
          end
        end
      end
      else begin
        if (c) begin
          if (d) begin
            q = 1'b1;
          end
          else begin
            q = 1'b0;
          end
        end
        else begin
          q = 1'b1;
        end
      end
    end
    else begin
      if (b) begin
        if (c) begin
          if (d) begin
            q = 1'b0;
          end
          else begin
            q = 1'b1;
          end
        end
        else begin
          q = 1'b0;
        end
      end
      else begin
        if (c) begin
          if (d) begin
            q = 1'b1;
          end
          else begin
            q = 1'b0;
          end
        end
        else begin
          q = 1'b0;
        end
      end
    end
  end

endmodule
