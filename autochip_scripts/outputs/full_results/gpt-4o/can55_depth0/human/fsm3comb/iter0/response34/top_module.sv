module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

    // Define state values for clarity
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (in == 1'b0) ? A : B;
            B: next_state = (in == 1'b0) ? C : B;
            C: next_state = (in == 1'b0) ? A : D;
            D: next_state = (in == 1'b0) ? C : B;
            default: next_state = A; // Default to state A for safety
        endcase
    end

    // Output logic
    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
