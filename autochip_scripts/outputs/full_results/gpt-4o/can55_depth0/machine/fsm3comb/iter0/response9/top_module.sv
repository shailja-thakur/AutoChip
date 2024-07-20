module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);
    // State encoding
    localparam [1:0] A = 2'b00, 
                     B = 2'b01,
                     C = 2'b10,
                     D = 2'b11;

    always @(*) begin
        // Default assignments
        next_state = state;
        out = 1'b0;  // Default out to be 0

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
                out = 1'b1; // Set out high when in state D
            end
            default: next_state = A;  // Default state
        endcase
    end

endmodule
