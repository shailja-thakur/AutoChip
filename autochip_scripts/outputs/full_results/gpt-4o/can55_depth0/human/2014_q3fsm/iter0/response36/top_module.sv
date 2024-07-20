module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define state encoding
    typedef enum logic [1:0] {
        A = 2'b00,  // Initial state
        B = 2'b01,  // Counting state
        C = 2'b10   // Decision state
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count; // Count the number of times w = 1 in 3 cycles
    reg [1:0] cycles;  // Count the cycles within state B

    // State transition logic (sequential)
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            z <= 0;
        end else begin
            state <= next_state;
        end
    end

    // State transition logic (combinational)
    always_comb begin
        // Default values for combinational logic to prevent latches
        next_state = state;
        case (state)
            A: begin
                if (s == 1)
                    next_state = B;
            end
            B: begin
                if (cycles == 3)  // After 3 cycles, move to decision state
                    next_state = C;
            end
            C: begin
                next_state = B;  // Return to state B to check w for the next 3 cycles
            end
        endcase
    end

    // Output and counter logic (sequential)
    always_ff @(posedge clk) begin
        if (reset) begin
            w_count <= 0;
            cycles <= 0;
            z <= 0;
        end else begin
            case (state)
                A: begin
                    w_count <= 0;
                    cycles <= 0;
                    z <= 0;
                end
                B: begin
                    cycles <= cycles + 1;
                    if (w == 1)
                        w_count <= w_count + 1;
                end
                C: begin
                    if (w_count == 2)
                        z <= 1;
                    else
                        z <= 0;
                    w_count <= 0;  // Reset the counter for the next check
                    cycles <= 0;   // Reset the cycle counter
                end
            endcase
        end
    end
endmodule
