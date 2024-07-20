module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // State One-Hot Encoding
    parameter A = 4'b0001;
    parameter B = 4'b0010;
    parameter C = 4'b0100;
    parameter D = 4'b1000;

    // State Transition Logic
    always @(*) begin
        case (state)
            A: next_state = (in == 0) ? A : B;
            B: next_state = (in == 0) ? C : B;
            C: next_state = (in == 0) ? A : D;
            D: next_state = (in == 0) ? C : B;
            default: next_state = 4'b0000; // Default state (should not happen)
        endcase
    end

    // Output Logic
    assign out = (state == D) ? 1 : 0;
endmodule
