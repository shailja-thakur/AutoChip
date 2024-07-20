module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State Encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Counters and Register for the three clock cycles examination in state B
    reg [1:0] w_counter;
    reg [1:0] cycle_counter;

    // Sequential Logic - State Transition
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            w_counter <= 2'b00;
            cycle_counter <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational Logic - Next State Logic and Output Logic
    always_comb begin
        // Default values
        next_state = current_state;
        z = 1'b0;

        case (current_state)
            A: begin
                if (s == 1) begin
                    next_state = B;
                end
            end
            B: begin
                // Increment the cycle counter
                cycle_counter = cycle_counter + 1;
                // Check the value of w
                if (w == 1) begin
                    w_counter = w_counter + 1;
                end
                // Check if three cycles have passed
                if (cycle_counter == 3) begin
                    if (w_counter == 2) begin
                        z = 1'b1;
                    end
                    // Reset the cycle counter and w counter for the next examination
                    cycle_counter = 2'b00;
                    w_counter = 2'b00;
                end
            end
        endcase
    end

endmodule
