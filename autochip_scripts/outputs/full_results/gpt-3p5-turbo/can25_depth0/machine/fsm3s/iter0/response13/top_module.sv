module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Define states
    typedef enum logic [1:0] {A, B, C, D} state;
    state current_state, next_state;

    // Register for state
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition logic
    always_comb begin
        case (current_state)
            A: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
            C: begin
                if (in) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            D: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
        endcase
    end

    // Output logic
    always_comb begin
        if (current_state == D) begin
            out = 1;
        end else begin
            out = 0;
        end
    end

endmodule
