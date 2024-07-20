module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;
parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        A: next_state = (in) ? B : A;
        B: next_state = (in) ? B : C;
        C: next_state = (in) ? D : A;
        D: next_state = (in) ? B : C;
        default: next_state = A;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        D: out = 1;
        default: out = 0;
    endcase
end

endmodule
