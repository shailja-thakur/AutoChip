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
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count;
    reg [2:0] sample_count; // Extend to 3-bit to handle up to 3 samples

    // State transition: Synchronous process
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            sample_count <= 3'b000;
            z <= 1'b0;
        end
        else begin
            state <= next_state;

            // Reset w_count and sample_count when moving to state A
            if (state == A) begin
                w_count <= 2'b00;
                sample_count <= 3'b000;
                z <= 1'b0;
            end

            if (state == B) begin
                // Only count w if in state B
                sample_count <= sample_count + 1'b1;
                if (w) w_count <= w_count + 1'b1;
                
                if (sample_count == 3'b011) begin // After 3 samples
                    if (w_count == 2'b10) z <= 1'b1;
                    else z <= 1'b0;
                    w_count <= 2'b00;
                    sample_count <= 3'b000;
                end
                else begin
                    z <= 1'b0;
                end
            end
        end
    end

    // Next state logic: Combinational process
    always_comb begin
        next_state = state;
        case(state)
            A: begin
                if (s == 1'b1) begin
                    next_state = B;
                end
            end

            B: begin
                if (sample_count == 3'b011) begin // After 3 samples, stay in B
                    next_state = B;
                end
                else begin
                    next_state = B;
                end
            end

            default: next_state = A;
        endcase
    end

endmodule
