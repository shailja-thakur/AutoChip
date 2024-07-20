module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State declaration
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg [1:0] count_w1; // Counter for w = 1 occurrences
    
    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next state logic and output logic
    always_comb begin
        next_state = state;
        z = 1'b0;
        case(state)
            A: begin
                if (s == 1) begin
                    next_state = B;
                end
            end
            
            B: begin
                if (count_w1 == 2) begin
                    z = 1'b1;
                end
                next_state = C; // Move to state C to count w occurrences
            end
            
            C: begin
                // Counting w occurrences for 3 clock cycles in state B
                if (count_w1 == 3) begin
                    next_state = B; // Check w occurrences again in state B
                end
            end
        endcase
    end
    
    // Counter for w = 1 occurrences in 3 clock cycles
    always_ff @(posedge clk) begin
        if (reset || state == A) begin
            count_w1 <= 2'b0;
        end else if (state == B) begin
            if (w == 1) begin
                count_w1 <= count_w1 + 1;
            end
            if (count_w1 == 3) begin
                count_w1 <= 2'b0; // Reset counter after 3 cycles
            end
        end
    end
endmodule
