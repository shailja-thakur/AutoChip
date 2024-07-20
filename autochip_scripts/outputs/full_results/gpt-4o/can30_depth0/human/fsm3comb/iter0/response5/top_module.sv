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
                next_state = in ? B : A;
                out = 0;
            end
            B: begin
                next_state = in ? B : C;
                out = 0;
            end
            C: begin
                next_state = in ? D : A;
                out = 0;
            end
            D: begin
                next_state = in ? B : C;
                out = 1;
            end
            default: begin
                next_state = A; // Default state
                out = 0;
            end
        endcase
    end

endmodule
