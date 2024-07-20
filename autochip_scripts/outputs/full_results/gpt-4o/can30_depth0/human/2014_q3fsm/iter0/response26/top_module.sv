module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,    // Reset state
        B1 = 3'b001,   // First cycle in state B
        B2 = 3'b010,   // Second cycle in state B
        B3 = 3'b011,   // Third cycle in state B
        B_CHECK = 3'b100 // Check after third cycle
    } state_t;
    
    state_t state, next_state;
    logic [1:0] w_count;   // Count of "1" in the w input over three cycles
    
    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        next_state = state; // Default to stay in the current state
        z = 0; // Default to output z = 0
        case (state)
            A: begin
                if (s)
                    next_state = B1;
            end
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = B_CHECK;
            B_CHECK: begin
                if (w_count == 2) z = 1;
                else z = 0;
                next_state = B1; // Continue with next three cycles
            end
        endcase
    end

    // Count logic to track the number of 1's in the w input
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            w_count <= 0;
        else if (state == B1)
            w_count <= w ? 2'b01 : 2'b00;
        else if (state == B2)
            w_count <= w_count + (w ? 2'b01 : 2'b00);
        else if (state == B3)
            w_count <= w_count + (w ? 2'b01 : 2'b00);
        else if (state == B_CHECK)
            w_count <= 0; // Reset the count after checking
    end
endmodule
