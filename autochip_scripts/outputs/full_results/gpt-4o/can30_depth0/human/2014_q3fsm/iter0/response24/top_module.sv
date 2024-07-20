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
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;
    reg [1:0] cycle_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
            cycle_count <= 0;
            z <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default values
        next_state = state;
        z = 0;

        case (state)
            A: begin
                w_count = 0;
                cycle_count = 0;
                if (s) begin
                    next_state = B;
                end
            end
            B: begin
                if (cycle_count == 3) begin
                    if (w_count == 2) begin
                        z = 1;
                    end else begin
                        z = 0;
                    end
                    w_count = 0;
                    cycle_count = 0;
                end else begin
                    cycle_count = cycle_count + 1;
                    if (w) begin
                        w_count = w_count + 1;
                    end
                    if (cycle_count == 2) begin
                        next_state = C;
                    end
                end
            end
            C: begin
                if (cycle_count == 3) begin
                    if (w_count == 2) begin
                        z = 1;
                    end else begin
                        z = 0;
                    end
                    w_count = 0;
                    cycle_count = 0;
                    next_state = B; // Continue the next 3 cycle examination in state B
                end else begin
                    cycle_count = cycle_count + 1;
                    if (w) begin
                        w_count = w_count + 1;
                    end
                end
            end
            default: next_state = A;
        endcase
    end
endmodule
