module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// State encoding
typedef enum logic [2:0] {
    A = 3'd0,
    B = 3'd1,
    C = 3'd2,
    D = 3'd3,
    E = 3'd4,
    F = 3'd5
} state_t;

// State registers
reg state, next_state;

// Combinational logic for state transitions
always @(*) begin
    case (state)
        A: next_state = (w) ? A : B;
        B: next_state = (w) ? D : C;
        C: next_state = (w) ? D : E;
        D: next_state = (w) ? A : F;
        E: next_state = (w) ? D : E;
        F: next_state = (w) ? D : C;
        default: next_state = A; // Should not happen
    endcase
end

// Sequential logic for state registration
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Output logic
always @(*) begin
    z = (state == E || state == F);
end

endmodule
