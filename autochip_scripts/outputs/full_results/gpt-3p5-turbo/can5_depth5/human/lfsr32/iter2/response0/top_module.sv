module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [4:0] state;

  always @(posedge clk) begin
    if (reset) begin
      q <= 32'h1;
      state <= 32'h1;
    end else begin
      case (state)
        0: begin
          q <= q << 1;
          q[0] <= q[22]^q[1]^q[0];
          state <= 1;
        end
        1: begin
          q <= q << 1;
          q[0] <= q[22]^q[1]^q[0];
          state <= 2;
        end
        2: begin
          q <= q << 1;
          q[0] <= q[22]^q[1]^q[0];
          state <= 3;
        end
        3: begin
          q <= q << 1;
          q[0] <= q[22]^q[1]^q[0];
          state <= 4;
        end
        4: begin
          q <= q << 1;
          q[0] <= q[22]^q[1]^q[0];
          state <= 0;
        end
      endcase
    end
  end

endmodule
