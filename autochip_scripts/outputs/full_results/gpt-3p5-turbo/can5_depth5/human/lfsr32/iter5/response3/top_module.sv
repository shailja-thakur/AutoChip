module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [4:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 32'h1;
      state <= 5'b00000;
    end else begin
      case (state)
        0: begin
          q <= q << 1;
          state <= 1;
        end
        1: begin
          q[0] <= q[22] ^ q[2] ^ q[1];
          state <= 2;
        end
        2: begin
          q[1:0] <= q[24:23] ^ q[4:3] ^ q[2:1];
          state <= 3;
        end
        3: begin
          q[2:0] <= q[25:23] ^ q[5:3] ^ q[4:2];
          state <= 4;
        end
        4: begin
          q[3:0] <= q[31:28] ^ q[7:4] ^ q[6:3];
          state <= 0;
        end
      endcase
    end
  end

endmodule
