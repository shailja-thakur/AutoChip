module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        CHECK1 = 2'b10,
        CHECK2 = 2'b11
    } state_t;

    state_t state, next_state;
    logic [1:0] w_count, next_w_count;
    logic [1:0] cycle_count, next_cycle_count;

    // Sequential block for state and counters
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b0;
            cycle_count <= 2'b0;
        end else begin
            state <= next_state;
            w_count <= next_w_count;
            cycle_count <= next_cycle_count;
        end
    end

    // Combinational block for next state and output logic
    always_comb begin
        // Default values
        next_state = state;
        next_w_count = w_count;
        next_cycle_count = cycle_count;
        z = 1'b0;

        case (state)
            A: begin
                if (s) 
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_cycle_count = cycle_count + 1;
                if (w) 
                    next_w_count = w_count + 1;

                if (cycle_count == 2'b10) begin // Checks after 3 clock cycles
                    if (w_count == 2'b10) 
                        z = 1'b1;
                    next_state = B;
                    next_cycle_count = 2'b0;
                    next_w_count = 2'b0;
                end
            end
        endcase
    end

endmodule
