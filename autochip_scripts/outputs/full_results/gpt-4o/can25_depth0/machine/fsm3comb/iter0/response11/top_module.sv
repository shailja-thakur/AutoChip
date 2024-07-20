module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    // Define state encoding
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // Always_comb block to define state transitions
    always @* begin
        case (state)
            A: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
            end
            C: begin
                if (in)
                    next_state = D;
                else
                    next_state = A;
            end
            D: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
            end
            default: next_state = A; // Default case to cover all possible inputs
        endcase
    end

    // Assign output 'out' to indicate when in state D
    assign out = (state == D);

endmodule
