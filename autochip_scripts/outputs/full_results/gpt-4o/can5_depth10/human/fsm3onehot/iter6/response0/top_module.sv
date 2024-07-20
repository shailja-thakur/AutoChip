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

    // State transition logic
    always @(*) begin
        next_state = 4'b0000; // Default to an invalid state (all zeros)
        case (state)
            4'b0001: next_state = (in) ? B : A; // A
            4'b0010: next_state = (in) ? B : C; // B
            4'b0100: next_state = (in) ? D : A; // C
            4'b1000: next_state = (in) ? B : C; // D
            default: next_state = 4'b0000; // If invalid state, force an invalid state
        endcase
    end

    // Output logic
    assign out = (state == D);

endmodule
