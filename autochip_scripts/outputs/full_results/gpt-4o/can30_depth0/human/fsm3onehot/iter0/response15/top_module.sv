module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    // State encodings
    parameter A = 4'b0001;
    parameter B = 4'b0010;
    parameter C = 4'b0100;
    parameter D = 4'b1000;

    always @(*) begin
        // Default values
        next_state = 4'b0000;
        out = 1'b0;

        case (state)
            A: begin
                if (in == 1'b0)
                    next_state = A;
                else
                    next_state = B;
                out = 1'b0;
            end
            B: begin
                if (in == 1'b0)
                    next_state = C;
                else
                    next_state = B;
                out = 1'b0;
            end
            C: begin
                if (in == 1'b0)
                    next_state = A;
                else
                    next_state = D;
                out = 1'b0;
            end
            D: begin
                if (in == 1'b0)
                    next_state = C;
                else
                    next_state = B;
                out = 1'b1;
            end
            default: begin
                next_state = A; // Default to state A
                out = 1'b0;
            end
        endcase
    end

endmodule
