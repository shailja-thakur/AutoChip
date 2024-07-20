module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;
always @(posedge clk or negedge reset) begin
  if (reset == 0) begin
    state <= 2'b00; // Initialize state to A
  end else begin
    case (state)
      2'b00: begin
        if (j == 1) begin
          state <= 2'b01; // Next state is B if j is high
        end
      end
      2'b01: begin
        if (k == 1) begin
          state <= 2'b00; // Next state is A if k is high
        end
      end
    endcase
  end
end

always @(state) begin
  if (state == 2'b01) begin
    out <= 1'b1; // Output is high when state is B
  end else begin
    out <= 1'b0; // Output is low when state is A
  end
end

endmodule
