module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
  
  reg state;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 1'b0; // Set state to A
    end else begin
      if (state == 1'b0) begin // State A
        if (j) begin
          state <= 1'b1; // Set state to B
        end
      end else begin // State B
        if (k) begin
          state <= 1'b0; // Set state to A
        end
      end
    end
  end
  
  assign out = state;
  
endmodule
