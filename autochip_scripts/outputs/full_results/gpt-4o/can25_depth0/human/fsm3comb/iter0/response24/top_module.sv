module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);
    // Define state encoding
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (in == 0)
                    next_state = A;
                else
                    next_state = B;
                out = 0;
            end
            B: begin
                if (in == 0)
                    next_state = C;
                else
                    next_state = B;
                out = 0;
            end
            C: begin
                if (in == 0)
                    next_state = A;
                else
                    next_state = D;
                out = 0;
            end
            D: begin
                if (in == 0)
                    next_state = C;
                else
                    next_state = B;
                out = 1;
            end
            default: begin
                next_state = A; // Undefined states default to A
                out = 0;
            end
        endcase
    end
endmodule
