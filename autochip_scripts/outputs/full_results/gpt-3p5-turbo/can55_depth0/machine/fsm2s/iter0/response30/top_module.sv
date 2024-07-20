module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;
parameter A = 2'b00;
parameter B = 2'b01;

// Initialize state to A on reset
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        case (state)
            A: state <= (j) ? B : A;
            B: state <= (k) ? A : B;
        endcase
 end

// Output is high when state is B, low otherwise
assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
