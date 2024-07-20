module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    localparam [2:0] A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

    // State register
    reg [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (w) ? A : B;
            B: next_state = (w) ? D : C;
            C: next_state = (w) ? D : E;
            D: next_state = (w) ? A : F;
            E: next_state = (w) ? D : E;
            F: next_state = (w) ? D : C;
            default: next_state = A;
        endcase
    end

    // Sequential logic
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*)
        z = (state == E || state == F);

endmodule
