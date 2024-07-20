module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State Encoding
    typedef enum reg [1:0] {
        A,  // Initial reset state
        B,  // First state after s is asserted
        C   // Collect states
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count; // Count the occurrences of w=1

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
        end else begin
            state <= next_state;
            if (next_state != C) w_count <= 2'b00;
        end
    end

    // Combinational logic for state transition and output
    always @(*) begin
        next_state = state;
        z = 0;
        
        case (state)
            A: begin
                if (s) begin
                    next_state = B;
                end
            end
            B: begin
                next_state = C;
            end
            C: begin
                // Use a counter to count 3 cycles
                if (w_count == 2'b11) begin
                    if (w) begin
                        // Checking the third cycle, need to increment
                        w_count <= w_count + 1;
                    end
                    
                    // Check if there are exactly 2 `w==1`s in last 3 cycles
                    if (w_count == 2'b10) begin
                        z = 1;
                    end
                    next_state = B; // Restart the check process
                end else begin
                    w_count <= w_count + w; // Only increment if w is 1
                end
            end
        endcase
    end

endmodule
