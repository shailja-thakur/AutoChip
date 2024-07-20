module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

// State encoding
typedef enum reg [2:0] {
    A = 3'b000,
    B = 3'b001,
    C = 3'b010,
    D = 3'b011,
    E = 3'b100
} state_t;

state_t state, next_state;

// Sequential logic for state transitions
always @(posedge clk or posedge reset) begin
    if (reset) 
        state <= A; // Initialize state to A on reset
    else 
        state <= next_state;
end

// Combinatorial logic for state transitions and output
always @(*) begin
    // Default next state and output
    next_state = state;
    z = 0;

    case (state)
        A: begin
            if (x) 
                next_state = B;
            else 
                next_state = A;
        end
        B: begin
            if (x) 
                next_state = E;
            else 
                next_state = B;
        end
        C: begin
            if (x) 
                next_state = B;
            else 
                next_state = C;
        end
        D: begin
            if (x) 
                next_state = C;
            else 
                next_state = B;
        end
        E: begin
            if (x)
                next_state = E;
            else 
                next_state = D;
        end
        default: 
            next_state = A;
    endcase

    // Output logic
    if (state == D || state == E)
        z = 1;
end

endmodule
