module top_module(
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q);

  // Always block triggered by a rising edge of clk
  always @(posedge clk) begin
    // If block with condition load
    if (load) begin
      // Case block with conditions ena
      case (ena)
        2'b00: begin
          // Assignment for case item 00
          q = {q[62:0], 1'b0};
        end
        2'b01: begin
          // Assignment for case item 01
          q = {q[55:0], 8'b0};
        end
        2'b10: begin
          // Assignment for case item 10
          q = {q[63], q[63:1]};
        end
        2'b11: begin
          // Assignment for case item 11
          q = {{8{q[63]}}, q[63:8]};
        end
        default: begin
          // Assignment for default item
          q = 64'hx;
        end
      endcase
    end
  end
endmodule
