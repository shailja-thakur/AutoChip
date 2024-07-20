module top_module (
  input [7:0] code,
  output reg [3:0] out,
  output reg valid
);

  always @* begin
    case (code)
      8'h45: begin
        valid = 1;
        out = 4'h0;
      end
      8'h16: begin
        valid = 1;
        out = 4'h1;
      end
      8'h1e: begin
        valid = 1;
        out = 4'h2;
      end
      8'h26: begin
        valid = 1;
        out = 4'h3;
      end
      8'h25: begin
        valid = 1;
        out = 4'h4;
      end
      8'h2e: begin
        valid = 1;
        out = 4'h5;
      end
      8'h36: begin
        valid = 1;
        out = 4'h6;
      end
      8'h3d: begin
        valid = 1;
        out = 4'h7;
      end
      8'h3e: begin
        valid = 1;
        out = 4'h8;
      end
      8'h46: begin
        valid = 1;
        out = 4'h9;
      end
      default: begin
        valid = 0;
        out = 0;
      end
    endcase
  end

endmodule
