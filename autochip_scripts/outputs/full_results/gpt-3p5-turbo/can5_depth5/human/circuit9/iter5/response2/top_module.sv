module top_module (
  input clk,
  input a,
  output reg [2:0] q
);
  
  reg [2:0] next_q;
  
  always @(posedge clk) begin
    if (a) begin
      case (q)
        3'b000: next_q <= 3'b000;
        3'b001: next_q <= 3'b001;
        3'b010: next_q <= 3'b001;
        3'b011: next_q <= 3'b001;
        3'b100: next_q <= 3'b001;
        3'b101: next_q <= 3'b001;
        3'b110: next_q <= 3'b001;
        3'b111: next_q <= 3'b000;
        default: next_q <= 3'b000;
      endcase
    end else begin
      case (q)
        3'b000: next_q <= 3'b100;
        3'b001: next_q <= 3'b100;
        3'b010: next_q <= 3'b100;
        3'b011: next_q <= 3'b100;
        3'b100: next_q <= 3'b100;
        3'b101: next_q <= 3'b101;
        3'b110: next_q <= 3'b110;
        3'b111: next_q <= 3'b000;
        default: next_q <= 3'b000;
      endcase
    end
  end
  
  always @(posedge clk) begin
    q <= next_q;
  end

endmodule
