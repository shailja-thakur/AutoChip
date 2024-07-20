module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// State variables
reg [1:0] state, next_state;

// State encodings
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

// Output logic
assign out = (state == D) ? 1'b1 : 1'b0;

// State register
always @(posedge clk, posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

endmodule
