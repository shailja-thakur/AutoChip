module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State declarations
    typedef enum logic {
        A = 1'b0,
        B = 1'b1
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            A: begin
                if (j) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                if (k) 
                    next_state = A;
                else 
                    next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            out <= 1'b0;
        end else begin
            out <= (state == B);
        end
    end

endmodule
