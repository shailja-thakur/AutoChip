module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

// State assignment
parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

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
        A, B, C: out = 1'b0;
        D: out = 1'b1;
    endcase
end

// State register
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

endmodule
