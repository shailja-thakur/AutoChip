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
        C = 2'b10
    } state_t;

    state_t state, next_state;

    reg [1:0] w_count; // Counter for w=1 in the last 3 cycles

    // State Transition Logic (Sequential)
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            z <= 0;
        end else begin
            state <= next_state;

            if (state == B && w_count == 2) begin
                z <= 1;
            end else if (state == B && w != 2) begin
                z <= 0;
            end
        end
    end

    // Next State and Output Logic (Combinational)
    always_comb begin
        next_state = state; // Default assignment
        case (state)
            A: begin
                if (s) next_state = B;
            end
            B: begin
                if (!s && w_count == 3) next_state = A;
            end
        endcase
    end

    // Counting logic
    always_ff @(posedge clk) begin
        if (reset || state == A) begin
            w_count <= 0;
        end else if (state == B) begin
            if (w) begin
                w_count <= w_count + 1;
            end

            if (w_count == 3) begin
                w_count <= 0;
            end
        end
    end

endmodule
