module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);
    // Define state encoding
    parameter A = 4'b0001, B = 4'b0010, C = 4'b0100, D = 4'b1000;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = 4'b0000; // Default case to handle unexpected input
        endcase
    end

    // Output logic
    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
