module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;  // On reset, go to state A
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        case (current_state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A;  // Safety fallback for invalid states
        endcase
    end
    
    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0;
        else
            out <= (current_state == D);
    end

endmodule
