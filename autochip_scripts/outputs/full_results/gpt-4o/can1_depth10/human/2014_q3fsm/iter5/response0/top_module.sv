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
    
    initial begin
        state = A;
        w_count = 0;
        cycle_count = 0;
        z = 0;
    end

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
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            z <= 0;
            w_count <= 0;
            cycle_count <= 0;
        end else begin
            z <= 0; // Default output

            case (state)
                A: begin
                    if (s) begin
                        next_state <= B;
                        w_count <= 0;
                        cycle_count <= 0;
                    end else begin
                        next_state <= A;
                    end
                end

                B: begin
                    if (cycle_count < 3) begin
                        if (w) begin
                            w_count <= w_count + 1;
                        end
                        cycle_count <= cycle_count + 1;
                        next_state <= B;
                    end else begin
                        if (w_count == 2) begin
                            z <= 1;
                        end
                        next_state <= C; // Go to a temporary state to reset counters
                    end
                end

                C: begin
                    z <= 0;
                    next_state <= A; // Return to A to check input "s" again
                    w_count <= 0;
                    cycle_count <= 0;
                end

                default: next_state <= A;
            endcase
        end
    end
endmodule
