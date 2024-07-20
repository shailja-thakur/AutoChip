module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State declarations
    typedef enum logic [1:0] {
        S_A = 2'b00,
        S_B = 2'b01,
        S_C = 2'b10,
        S_D = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_A;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        case (state)
            S_A: begin
                if (in) begin
                    next_state = S_B;
                end else begin
                    next_state = S_A;
                end
                out = 1'b0;
            end
            S_B: begin
                if (in) begin
                    next_state = S_B;
                end else begin
                    next_state = S_C;
                end
                out = 1'b0;
            end
            S_C: begin
                if (in) begin
                    next_state = S_D;
                end else begin
                    next_state = S_A;
                end
                out = 1'b0;
            end
            S_D: begin
                if (in) begin
                    next_state = S_B;
                end else begin
                    next_state = S_C;
                end
                out = 1'b1;
            end
            default: begin
                next_state = S_A;
                out = 1'b0;
            end
        endcase
    end

endmodule
