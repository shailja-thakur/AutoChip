module top_module(
    input clk,
    input in,
    input reset,
    output out
);

    // State encoding
    typedef enum reg {A, B} state_t;

    // State register
    state_t state, next_state;

    // Sequential logic: state transition on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B; // Reset state
        end
        else begin
            state <= next_state; // Update state
        end
    end

    // Combinational logic: next state logic
    always @(*) begin
        case (state)
            A: begin
                if (in) begin
                    next_state = A;
                end
                else begin
                    next_state = B;
                end
            end
            B: begin
                if (in) begin
                    next_state = B;
                end
                else begin
                    next_state = A;
                end
            end
            default: next_state = B; // Default state
        endcase
    end

    // Output logic
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
