module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // Define states
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count; // counter for counting w=1 in 3 clock cycles
    reg [1:0] cycle_count; // counter for counting 3 clock cycles

    // Synchronous state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
            cycle_count <= 0;
            z <= 0;
        end
        else begin
            state <= next_state;
            if (state == B || state == C || state == D) begin
                w_count <= (w_count + w);
                cycle_count <= cycle_count + 1;
            end

            // Output logic
            if (cycle_count == 2'b11) begin // After 3 clock cycles
                if (w_count == 2) begin
                    z <= 1;
                end
                else begin
                    z <= 0;
                end
                w_count <= 0; // Reset counter
                cycle_count <= 0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            A: if (s) next_state = B; else next_state = A;
            B: if (cycle_count == 2'b11) next_state = B; else next_state = C;
            C: if (cycle_count == 2'b11) next_state = B; else next_state = D;
            D: if (cycle_count == 2'b11) next_state = B; else next_state = B;
            default: next_state = A;
        endcase
    end

endmodule
