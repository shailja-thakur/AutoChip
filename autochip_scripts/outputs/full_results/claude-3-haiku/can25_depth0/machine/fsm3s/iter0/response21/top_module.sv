module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;
localparam A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

// State register
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        A: next_state = (in) ? B : A;
        B: next_state = (in) ? B : C;
        C: next_state = (in) ? D : A;
        D: next_state = (in) ? B : C;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        D: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
