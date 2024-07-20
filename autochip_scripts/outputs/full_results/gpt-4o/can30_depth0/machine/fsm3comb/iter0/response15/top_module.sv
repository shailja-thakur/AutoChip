module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    // Define state codes
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    always @(*) begin
        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A; // Fallback state
        endcase
    end

    // Output signal is high when in state D
    assign out = (state == D) ? 1 : 0;
endmodule
