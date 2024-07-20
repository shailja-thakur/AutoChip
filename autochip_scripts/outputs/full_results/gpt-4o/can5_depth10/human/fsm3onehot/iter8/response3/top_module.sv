module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    // State encoding
    parameter A = 4'b0001;
    parameter B = 4'b0010;
    parameter C = 4'b0100;
    parameter D = 4'b1000;

    // State transition and output logic
    always @(*) begin
        // Default values to avoid latches
        next_state = 4'b0000;
        out = 0;

        // State transition logic
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = 4'b0000; // This handles unexpected state inputs
        endcase
        
        // Output logic
        out = (state == D) ? 1 : 0;
    end
endmodule
