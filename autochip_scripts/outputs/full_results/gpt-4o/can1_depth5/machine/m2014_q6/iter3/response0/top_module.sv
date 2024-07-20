module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // State encoding
    localparam [2:0] A = 3'b000,
                     B = 3'b001,
                     C = 3'b010,
                     D = 3'b011,
                     E = 3'b100,
                     F = 3'b101;

    // Current state and next state variables
    reg [2:0] current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: next_state = !w ? B : A;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = !w ? F : A;
            E: next_state = w ? D : E;
            F: next_state = !w ? C : D;
            default: next_state = A;
        endcase
    end

    // State flip-flop with asynchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end
endmodule
