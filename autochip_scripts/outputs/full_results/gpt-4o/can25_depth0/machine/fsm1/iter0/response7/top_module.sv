module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define state encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (in) 
                   next_state = A;
               else 
                   next_state = B;
            B: if (in) 
                   next_state = B;
               else 
                   next_state = A;
            default: next_state = B; // Default state
        endcase
    end

    // Update state on clock edge or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= B;
        else 
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset) 
            out <= 1;
        else if (state == B)
            out <= 1;
        else
            out <= 0;
    end
endmodule
