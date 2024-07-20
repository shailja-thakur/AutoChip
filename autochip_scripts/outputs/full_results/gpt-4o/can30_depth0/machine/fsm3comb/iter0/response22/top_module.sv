module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);
    // State encoding
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // State Transition Logic
    always @(*) begin
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
            default: next_state = A; // default state to handle unexpected states
        endcase
    end

    // Output Logic
    always @(*) begin
        if (state == D)
            out = 1;
        else 
            out = 0;
    end
endmodule
