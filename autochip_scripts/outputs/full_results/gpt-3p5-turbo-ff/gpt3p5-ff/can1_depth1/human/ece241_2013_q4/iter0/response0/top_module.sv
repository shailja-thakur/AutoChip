module top_module (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

reg [3:1] s_reg; // Register to store previous sensor values
reg [2:0] state; // State to determine the water level condition

parameter ABOVE_S3 = 3'b100;
parameter BETWEEN_S3_S2 = 3'b110;
parameter BETWEEN_S2_S1 = 3'b111;
parameter BELOW_S1 = 3'b000;

always @(posedge clk) begin
  if (reset) begin
    fr3 <= 1'b1; // Default all outputs to high
    fr2 <= 1'b1;
    fr1 <= 1'b1;
    dfr <= 1'b1;
    s_reg <= 3'b000; // Default all previous sensor values to low
    state <= BELOW_S1; // Set initial state
  end else begin
    s_reg <= s; // Store current sensor values in register
    case (state)
      ABOVE_S3:
        begin
          fr3 <= 1'b0;
          fr2 <= 1'b0;
          fr1 <= 1'b0;
          dfr <= 1'b0;
          if (s[1] && !s[2] && !s[3])
            state <= BETWEEN_S3_S2;
          else if (!s[1] && !s[2] && !s[3])
            state <= BELOW_S1;
        end
      BETWEEN_S3_S2:
        begin
          fr3 <= 1'b0;
          fr2 <= 1'b0;
          fr1 <= 1'b1;
          dfr <= 1'b0;
          if (!s[1] && s[2] && !s[3])
            state <= ABOVE_S3;
          else if (s[1] && !s[2] && !s[3])
            state <= BETWEEN_S2_S1;
          else if (!s[1] && !s[2] && !s[3])
            state <= BELOW_S1;
        end
      BETWEEN_S2_S1:
        begin
          fr3 <= 1'b0;
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          dfr <= 1'b0;
          if (!s[1] && !s[2] && s[3])
            state <= BETWEEN_S3_S2;
          else if (!s[1] && !s[2] && !s[3])
            state <= BELOW_S1;
        end
      BELOW_S1:
        begin
          fr3 <= 1'b1;
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          dfr <= 1'b1;
          if (s[1] && !s[2] && !s[3])
            state <= BETWEEN_S2_S1;
          else if (!s[1] && !s[2] && s[3])
            state <= ABOVE_S3;
        end
      default: state <= BELOW_S1;
    endcase
  end
end

endmodule
