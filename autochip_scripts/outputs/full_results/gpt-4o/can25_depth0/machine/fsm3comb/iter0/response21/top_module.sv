module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    // Define state values for readability
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // Always block for state transitions
    always @(*) begin
        case(state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A; // Default state when undefined state is reached
        endcase
    end

    // Assign 'out' high when state is D
    always @(*) begin
        out = (state == D);
    end

endmodule
