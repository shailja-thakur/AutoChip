module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

// State assignment
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

// Next state logic
always @(*) begin
    case (state)
        A: next_state = (in) ? B : A;
        B: next_state = (in) ? B : C;
        C: next_state = (in) ? D : A;
        D: next_state = (in) ? B : C;
    endcase
end

// State register update
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

// Output logic
always @(posedge clk or posedge areset) begin
    if (areset)
        out <= 1'b0;
    else
        out <= (state == D) ? 1'b1 : 1'b0;
end

endmodule
