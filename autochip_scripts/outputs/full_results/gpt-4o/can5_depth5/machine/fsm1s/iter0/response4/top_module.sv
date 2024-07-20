module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg {A = 1'b0, B = 1'b1} state_t;
    state_t state, next_state;

    // Combinational logic to determine the next state
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
            default: 
                   next_state = A;  // Default state
        endcase
    end

    // Sequential logic to update state on rising edge of clk or reset
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= B;
        else 
            state <= next_state;
    end

    // Output logic
    always @(state) begin
        out = (state == B);
    end
endmodule
