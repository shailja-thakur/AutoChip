module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);
    // Encoding states
    localparam A = 2'b00,
               B = 2'b01,
               C = 2'b10,
               D = 2'b11;

    always @(*) begin
        case (state)
            A: if (in) next_state = B;
               else next_state = A;
            B: if (in) next_state = B;
               else next_state = C;
            C: if (in) next_state = D;
               else next_state = A;
            D: if (in) next_state = B;
               else next_state = C;
            default: next_state = A; // Default case to avoid latches
        endcase
    end

    // Output logic
    always @(*) begin
        if (state == D)
            out = 1'b1;
        else
            out = 1'b0;
    end
endmodule
