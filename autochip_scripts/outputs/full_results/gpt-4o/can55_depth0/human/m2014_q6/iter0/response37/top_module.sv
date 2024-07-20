module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // State encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    // State registers
    state_t current_state, next_state;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end
        else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        // Default next state to current state
        next_state = current_state;
        z = 1'b0;

        case (current_state)
            A: if (w) next_state = A; else next_state = B;
            B: if (w) next_state = D; else next_state = C;
            C: if (w) next_state = D; else next_state = E;
            D: if (w) next_state = A; else next_state = F;
            E: begin
                z = 1'b1;
                if (w) next_state = D; else next_state = E;
            end
            F: begin
                z = 1'b1;
                if (w) next_state = D; else next_state = C;
            end
            default: next_state = A;
        endcase
    end

endmodule
