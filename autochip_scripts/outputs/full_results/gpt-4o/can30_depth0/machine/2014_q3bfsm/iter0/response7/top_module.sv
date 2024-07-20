module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;
    
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        case (current_state)
            A: if (x) next_state = B; else next_state = A;
            B: if (x) next_state = E; else next_state = B;
            C: if (x) next_state = B; else next_state = C;
            D: if (x) next_state = C; else next_state = B;
            E: if (x) next_state = E; else next_state = D;
            default: next_state = A;  // This should not occur
        endcase
    end
    
    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            z <= 0;
        end else begin
            z <= (current_state == D) || (current_state == E);
        end
    end

endmodule
