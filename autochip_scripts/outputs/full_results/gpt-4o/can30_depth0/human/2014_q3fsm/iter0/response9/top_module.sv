module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,  // Initial state
        B = 2'b01,  // State after transition from A
        C = 2'b10,  // State for counting w cycles
        D = 2'b11   // Temporary or additional state if needed
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count;  // Counter for 'w' input being 1 during the 3 cycles in state B
    reg [1:0] cycle_count;  // Counter for 3 clock cycles in state B

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            z <= 0;
            w_count <= 0;
            cycle_count <= 0;
        end else begin
            state <= next_state;

            if (state == B) begin
                cycle_count <= cycle_count + 1;
                if (w) w_count <= w_count + 1;
                if (cycle_count == 2) begin
                    if (w_count == 2) z <= 1;
                    else z <= 0;
                    w_count <= 0;
                    cycle_count <= 0;
                end
            end else begin
                cycle_count <= 0;
                w_count <= 0;
            end
        end
    end

    always @(*) begin
        case (state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                if (cycle_count < 2) next_state = B;
                else next_state = B;  // Stay in B to keep checking every subsequent 3 cycles
            end
            default: next_state = A;
        endcase
    end

endmodule
