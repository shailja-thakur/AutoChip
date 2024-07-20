module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // Define states using local parameters
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

    // State register
    reg [1:0] state, next_state;

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A; // Default state should any unforeseen cases occur
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset to state A
        else
            state <= next_state; // Transition to next state
    end

    // Output logic
    always @(*) begin
        out = (state == D) ? 1'b1 : 1'b0;
    end

endmodule
