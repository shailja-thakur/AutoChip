module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

reg [3:0] state;
reg next_state;

parameter [3:0] S0 = 4'b0000;
parameter [3:0] S1 = 4'b0001;
parameter [3:0] S2 = 4'b0010;
parameter [3:0] S3 = 4'b0011;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= S0;
    start_shifting <= 0;
  end else begin
    state <= next_state;
    start_shifting <= (state == S3);
  end
end

always @(state or data) begin
  next_state = S0;
  case(state)
    S0: if (data) next_state = S1;
    S1: if (data) next_state = S2;
         else next_state = S0;
    S2: if (data) next_state = S3;
         else if (!data) next_state = S0;
    S3: if (!data) next_state = S0;
  endcase
end

endmodule
