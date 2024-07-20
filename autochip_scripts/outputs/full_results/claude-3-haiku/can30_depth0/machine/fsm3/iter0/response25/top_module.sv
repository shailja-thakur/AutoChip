module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

// Sequential logic for state register
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

// Combinational logic for next state
always @(*) begin
    case (state)
        A: next_state = in ? B : A;
        B: next_state = in ? B : C;
        C: next_state = in ? D : A;
        D: next_state = in ? B : C;
        default: next_state = A;
    endcase
end

// Combinational logic for output
always @(*) begin
    out = (state == D);
end

endmodule
