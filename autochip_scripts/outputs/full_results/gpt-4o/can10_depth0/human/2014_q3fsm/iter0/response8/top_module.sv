module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define states
    typedef enum logic [1:0] {
        A,
        B,
        C,
        D,
        E,
        F
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        z = 0;
        case (state)
            A: begin
                if (s) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                next_state = C;
            end
            C: begin
                next_state = D;
            end
            D: begin
                next_state = E;
            end
            E: begin
                if (w_count == 2) begin
                    z = 1;
                end else begin
                    z = 0;
                end
                next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // Output logic and w_count logic
    always_ff @(posedge clk) begin
        if (reset) begin
            w_count <= 0;
        end else if (state == B) begin
            w_count <= 0;
        end else if (state == C || state == D || state == E) begin
            if (w) begin
                w_count <= w_count + 1;
            end
        end
    end

endmodule
