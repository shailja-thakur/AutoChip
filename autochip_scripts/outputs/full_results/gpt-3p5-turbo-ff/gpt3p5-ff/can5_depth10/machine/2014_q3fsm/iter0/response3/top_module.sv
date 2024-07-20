module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define states
typedef enum logic [3:0] {
    A,
    B,
    C,
    S10,
    S11,
    S20,
    S21,
    S22
} state_t;

// Declare current and next state variables
reg [3:0] state, next_state;

// Initialize current state
initial begin
    state = A;
    next_state = A;
end

// Declare state transition logic
always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Declare state transition conditions
always_comb begin
    case (state)
        A: begin
            if (s) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end

        B: begin
            if (w) begin
                next_state = S11;
            end else begin
                next_state = S10;
            end
        end

        C: begin
            if (w) begin
                next_state = S11;
            end else begin
                next_state = S10;
            end
        end

        S10: begin
            if (w) begin
                next_state = S21;
            end else begin
                next_state = S20;
            end
        end

        S11: begin
            if (w) begin
                next_state = S22;
            end else begin
                next_state = S21;
            end
        end

        S20: begin
            next_state = B;
        end

        S21: begin
            if (w) begin
                next_state = C;
            end else begin
                next_state = B;
            end
        end

        S22: begin
            if (w) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
    endcase
end

// Default assignment for output
always_comb begin
    case (state)
        A: begin
            z = 0;
        end

        B: begin
            z = 0;
        end

        C: begin
            z = 0;
        end

        S10: begin
            z = 0;
        end

        S11: begin
            z = 0;
        end

        S20: begin
            z = 0;
        end

        S21: begin
            z = 0;
        end

        S22: begin
            z = 0;
        end
    endcase
end

endmodule
