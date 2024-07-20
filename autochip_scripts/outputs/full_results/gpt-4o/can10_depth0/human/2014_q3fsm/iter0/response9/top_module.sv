module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State definition
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count; // Counter for the number of 1's in the last three cycles
    reg [1:0] cycle_count; // Counter for the three cycles in state B

    // State transition logic
    always @ (posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @ (*) begin
        // Default values
        next_state = state;
        case (state)
            A: begin
                if (s == 1'b1)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (cycle_count == 2'b10) begin // 3 cycles completed
                    if (w_count == 2'b10) // Two 1's counted
                        z = 1'b1;
                    else
                        z = 1'b0;
                    cycle_count = 2'b00; // Reset cycle count
                    w_count = 2'b00; // Reset w_count for next round of 3 cycles
                end else begin
                    cycle_count = cycle_count + 1;
                    if (w == 1)
                        w_count = w_count + 1;
                    z = 1'b0;
                end
                next_state = B;
            end
            default: // Manage default case
                next_state = A;
        endcase
    end

endmodule
