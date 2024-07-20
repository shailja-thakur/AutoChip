module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State declarations
    typedef enum logic [1:0] {
        A = 2'b00,  // Reset state
        B = 2'b01,  // Check w for 3 clock cycles
        C = 2'b10   // Hold z for 1 clock cycle
    } state_t;
    
    state_t state, next_state;
    reg [1:0] count;  // Counter for '1's in w
    reg [1:0] cycle_count; // Counter for cycles

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;
            if (state == B) begin
                cycle_count <= cycle_count + 1;
                if (w) count <= count + 1;
            end else begin
                cycle_count <= 2'b00;
                count <= 2'b00;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        z = 1'b0;
        case (state)
            A: begin
                if (s)
                    next_state = B;
            end
            B: begin
                if (cycle_count == 2'b10) begin // Three clock cycles completed
                    if (count == 2'b10)
                        z = 1'b1; // Set z for one cycle if exactly two '1's
                    next_state = C;
                end
            end
            C: begin
                z = 1'b0;
                next_state = B;
            end
        endcase
    end

endmodule
