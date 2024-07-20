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
    end else begin
      case (state)
        2'b00: begin // Water level is below s[1]
          if (s == 3'b000) begin // None of the sensors are asserted
            state <= 2'b00;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
          end else if (s == 3'b001) begin // Only s[1] is asserted
            state <= 2'b01;
            fr3 <= 1'b0;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
          end else if (s == 3'b011) begin // s[1] and s[2] are asserted
            state <= 2'b10;
            fr3 <= 1'b0;
            fr2 <= 1'b1;
            fr1 <= 1'b0;
            dfr <= 1'b0;
          end else if (s == 3'b111) begin // s[1], s[2], and s[3] are asserted
            state <= 2'b00;
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b1;
          end
        end
        2'b01: begin // Water level is between s[1] and s[2]
          if (s == 3'b001) begin // Only s[1] is asserted
            state <= 2'b01;
            fr3 <= 1'b0;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
          end else if (s == 3'b011) begin // s[1] and s[2] are asserted
            state <= 2'b10;
            fr3 <= 1'b0;
            fr2 <= 1'b1;
            fr1 <= 1'b0;
            dfr <= 1'b0;
          end else if (s == 3'b111) begin // s[1], s[2], and s[3] are asserted
            state <= 2'b00;
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b1;
          end
        end
        2'b10: begin // Water level is between s[2] and s[3]
          if (s == 3'b001) begin // Only s[1] is asserted
            state <= 2'b01;
            fr3 <= 1'b0;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
          end else if (s == 3'b111) begin // s[1], s[2], and s[3] are asserted
            state <= 2'b00;
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b1;
          end
        end
      endcase
    end
  end

endmodule
