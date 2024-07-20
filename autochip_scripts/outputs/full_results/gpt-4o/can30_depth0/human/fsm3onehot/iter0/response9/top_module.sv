module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // State encoding
    parameter A = 4'b0001;
    parameter B = 4'b0010;
    parameter C = 4'b0100;
    parameter D = 4'b1000;

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
            default: next_state = A; // Default to state A
        endcase
    end

    // Output logic
    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
