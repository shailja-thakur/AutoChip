module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  reg [2:0] q_next; // New variable to store the next state of q
  
  initial begin
    q = 3'b0; // Initialize q to 0 at the start of simulation
  end

  always @(posedge clk) begin
    if (a) begin
      case (q)
        3'b001: q_next <= 3'b100;
        3'b100: q_next <= 3'b101;
        3'b101: q_next <= 3'b100;
        3'b110: q_next <= 3'b000;
        default: q_next <= q; // No change in q when a = 1
      endcase
    end else begin
      case (q)
        3'b000: q_next <= 3'b001;
        3'b001: q_next <= 3'b010;
        3'b010: q_next <= 3'b011;
        3'b011: q_next <= 3'b100;
        3'b100: q_next <= 3'b101;
        3'b101: q_next <= 3'b110;
        3'b110: q_next <= 3'b000;
        default: q_next <= q; // No change in q when a = 0
      endcase
    end
  end
  
  always @(posedge clk) begin
    q <= q_next; // Update the value of q with the next state
  end

endmodule
