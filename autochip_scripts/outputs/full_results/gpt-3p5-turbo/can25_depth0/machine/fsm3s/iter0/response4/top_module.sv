module top_module (
    input clk,
    input in,
    input reset,
    output out
);

// Define the 4 states
typedef enum logic [1:0] {
    A,
    B,
    C,
    D
} state_type;

// Define the current state and the next state
reg state_reg;
reg next_state;

always_ff @(posedge clk) begin
    if (reset) begin
        state_reg <= A; // Reset to initial state A
    end else begin
        state_reg <= next_state; // Transition to next state
    end
end

always_comb begin
    case (state_reg)
        A: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        
        B: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
        
        C: begin
            if (in) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        
        D: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
    endcase
end

assign out = (state_reg == D) ? 1 : 0;

endmodule
