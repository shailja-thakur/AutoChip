module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define the states
    typedef enum logic {
        A = 1'b0,
        B = 1'b1
    } state_t;
    
    state_t current_state, next_state;

    // Initialize the state to A on reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition logic
    always @(*) begin
        case (current_state)
            A: begin
                if (j) next_state = B;
                else next_state = A;
            end
            B: begin
                if (k) next_state = A;
                else next_state = B;
            end
            default: next_state = A; // Default state
        endcase
    end

    // Output logic
    always @(*) begin
        if (current_state == B) out = 1'b1;
        else out = 1'b0;
    end

endmodule
