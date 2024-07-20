module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [1:0] {A=2'b00, B=2'b01, C=2'b10} state_t;
    state_t state, next_state;
    logic [1:0] w_count;         // To count the number of times w is 1 in three clock cycles
    logic [1:0] cycle_count;     // To count the three clock cycles

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
            cycle_count <= 0;
            z <= 0;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = state;
        z = 0; // Default value
        case (state)
            A: begin
                if (s) begin
                    next_state = B;
                    cycle_count = 0;
                    w_count = 0;
                end
            end
            B: begin
                if (cycle_count == 3) begin
                    if (w_count == 2) 
                        z = 1;
                    
                    next_state = A; // Return to A to check input "s" again
                end
                else begin
                    next_state = B;
                end
            end
            default: next_state = A;
        endcase
    end

    // Cycle and w_count counters
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            cycle_count <= 0;
            w_count <= 0;
        end
        else if (state == B) begin
            if (cycle_count == 3) begin
                cycle_count <= 0;
                w_count <= 0;
            end
            else begin
                cycle_count <= cycle_count + 1;
                if (w) 
                    w_count <= w_count + 1;
            end
        end
    end
endmodule
