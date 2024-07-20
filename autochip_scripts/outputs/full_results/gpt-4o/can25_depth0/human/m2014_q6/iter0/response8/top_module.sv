module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // State declaration
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;
    
    // State registers
    state_t state, next_state;
    
    // Output logic based on state
    always @(*) begin
        case (state)
            A: z = 0;
            B: z = 0;
            C: z = 0;
            D: z = 0;
            E: z = 1;
            F: z = 1;
            default: z = 0;
        endcase
    end

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (w == 0) ? B : A;
            B: next_state = (w == 0) ? C : D;
            C: next_state = (w == 0) ? E : D;
            D: next_state = (w == 0) ? F : A;
            E: next_state = (w == 0) ? E : D;
            F: next_state = (w == 0) ? C : D;
            default: next_state = A;
        endcase
    end

    // State register update logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
endmodule
