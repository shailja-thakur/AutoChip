module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    
    // State declaration
    typedef enum logic [2:0] {
        A, B, C, D, E, F
    } state_t;

    // State register and next state logic
    reg state_t current_state, next_state;
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always_comb begin
        case (current_state)
            A: begin
                if (w == 1'b0) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (w == 1'b1) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
            end
            C: begin
                if (w == 1'b1) begin
                    next_state = D;
                end else begin
                    next_state = E;
                end
            end
            D: begin
                if (w == 1'b1) begin
                    next_state = A;
                end else begin
                    next_state = F;
                end
            end
            E: begin
                if (w == 1'b1) begin
                    next_state = D;
                end else begin
                    next_state = E;
                end
            end
            F: begin
                if (w == 1'b1) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
            end
            default: next_state = A;
        endcase
    end

    // Output assignment
    assign z = (current_state == E || current_state == F) ? 1'b1 : 1'b0;

endmodule
