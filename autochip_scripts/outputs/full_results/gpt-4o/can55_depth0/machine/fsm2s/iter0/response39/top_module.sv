module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State declaration
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t current_state, next_state;

    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        case (current_state)
            A: begin
                if (j) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
                out = 1'b0;
            end
            B: begin
                if (k) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
                out = 1'b1;
            end
            default: begin
                next_state = A;
                out = 1'b0;
            end
        endcase
    end

endmodule
