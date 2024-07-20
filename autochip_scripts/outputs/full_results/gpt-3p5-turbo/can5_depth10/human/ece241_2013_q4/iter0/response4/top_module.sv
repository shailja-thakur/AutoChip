module top_module (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

  reg [1:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      fr3 <= 1'b1;
      fr2 <= 1'b1;
      fr1 <= 1'b1;
      dfr <= 1'b1;
    end
    else begin
      case (state)
        2'b00: begin
          if (s[3])
            state <= 2'b00;
          else if (s[2])
            state <= 2'b01;
          else if (s[1])
            state <= 2'b10;
        end
        2'b01: begin
          if (s[3])
            state <= 2'b00;
          else if (s[1])
            state <= 2'b10;
          else
            state <= 2'b01;
        end
        2'b10: begin
          if (s[3])
            state <= 2'b00;
          else if (s[2])
            state <= 2'b01;
          else if (!s[1])
            state <= 2'b10;
        end
      endcase

      case (state)
        2'b00: begin
          fr1 <= 1'b0;
          fr2 <= 1'b0;
          fr3 <= 1'b0;
          dfr <= 1'b0;
        end
        2'b01: begin
          fr1 <= 1'b1;
          fr2 <= 1'b0;
          fr3 <= 1'b0;
          dfr <= 1'b0;
        end
        2'b10: begin
          fr1 <= 1'b1;
          fr2 <= 1'b1;
          fr3 <= 1'b0;
          dfr <= 1'b0;
        end
      endcase
    end
  end

endmodule
