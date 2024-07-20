module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states 
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            A: if (in) next_state = A; else next_state = B;
            B: if (in) next_state = B; else next_state = A;
            default: next_state = B;
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(state) begin
        if (state == B) 
            out = 1;
        else 
            out = 0;
    end

endmodule
