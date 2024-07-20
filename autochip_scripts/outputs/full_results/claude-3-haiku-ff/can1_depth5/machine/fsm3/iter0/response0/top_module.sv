module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

// State definitions
localparam A = 2'b00;
localparam B = 2'b01;
localparam C = 2'b10;
localparam D = 2'b11;

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

// State register update
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

// Output logic
assign out = (state == D);

endmodule
