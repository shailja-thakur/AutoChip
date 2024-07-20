module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// State registers
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
        default: next_state = A; // Ensure a valid next state
    endcase
end

// Output logic
assign out = (state == D);

// Sequential logic
always @(posedge clk) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

endmodule
