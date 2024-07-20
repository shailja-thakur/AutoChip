module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    // State encoding
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    always @(*) begin
        case (state)
            A: begin
                if (in) next_state = B;
                else next_state = A;
                out = 1'b0;
            end
            B: begin
                if (in) next_state = B;
                else next_state = C;
                out = 1'b0;
            end
            C: begin
                if (in) next_state = D;
                else next_state = A;
                out = 1'b0;
            end
            D: begin
                if (in) next_state = B;
                else next_state = C;
                out = 1'b1;
            end
            default: begin
                next_state = A; // Default state
                out = 1'b0;
            end
        endcase
    end

endmodule
