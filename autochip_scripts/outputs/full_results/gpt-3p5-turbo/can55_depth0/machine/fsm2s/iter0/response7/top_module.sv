module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
   
reg [1:0] state;
wire next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= A;
    else if (state == A)
        state <= (j) ? B : A;
    else if (state == B)
        state <= (k) ? A : B;
end

assign next_state = (state == B) ? 1'b1 : 1'b0;
assign out = next_state;

endmodule
