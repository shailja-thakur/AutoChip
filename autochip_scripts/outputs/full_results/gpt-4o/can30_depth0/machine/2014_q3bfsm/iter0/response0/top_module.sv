module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define state encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;

    // Declare state variables
    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A; // Initialize state to A on reset
        end else begin
            current_state <= next_state; // Transition to the next state
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: next_state = x ? B : A;
            B: next_state = x ? E : B;
            C: next_state = x ? B : C;
            D: next_state = x ? C : B;
            E: next_state = x ? E : D;
            default: next_state = A; // Default to state A in case of unknown state
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            D, E: z = 1;
            default: z = 0;
        endcase
    end

endmodule
