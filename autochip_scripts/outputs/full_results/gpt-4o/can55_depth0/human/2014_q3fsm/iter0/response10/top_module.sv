module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State encoding
    typedef enum reg [1:0] {A, B, C, D, E} state_t;
    state_t current_state, next_state;

    // Counters for the clock cycles and w inputs
    reg [1:0] w_counter;
    reg [1:0] cycle_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            w_counter <= 2'b0;
            cycle_counter <= 2'b0;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            
            // Manage w and cycle counters
            if (current_state == B || current_state == C || current_state == D) begin
                cycle_counter <= cycle_counter + 1;

                if (w == 1'b1) begin
                    w_counter <= w_counter + 1;
                end
            end

            // Set and reset z in E state
            if (current_state == E) begin
                if (w_counter == 2'b10) begin
                    z <= 1'b1;
                end else begin
                    z <= 1'b0;
                end
                // Reset counters
                w_counter <= 2'b0;
                cycle_counter <= 2'b0;
            end
        end
    end

    always @(*) begin
        next_state = current_state; // Default state transition to current state
        case (current_state)
            A: if (s) next_state = B;
            B: if (cycle_counter == 2'b10) next_state = E;
            C: if (cycle_counter == 2'b10) next_state = E;
            D: if (cycle_counter == 2'b10) next_state = E;
            E: next_state = B; // After evaluation, return to state B
        endcase
    end
endmodule
