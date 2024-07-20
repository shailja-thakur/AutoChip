module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S_WAIT = 2'b00,  // Wait for reset release
        S_COPY = 2'b01,  // Copy bits until first '1' is encountered
        S_INVERT = 2'b10 // Invert bits after the first '1'
    } state_t;
    
    state_t state, next_state;

    // Sequential block for state transition on clock edge
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_WAIT;
        else
            state <= next_state;
    end

    // Combinational block for state transition logic
    always @(*) begin
        case (state)
            S_WAIT: begin
                z = 0;
                if (!areset)
                    next_state = S_COPY;
                else
                    next_state = S_WAIT;
            end

            S_COPY: begin
                z = x;
                if (x == 1'b1)
                    next_state = S_INVERT;
                else
                    next_state = S_COPY;
            end

            S_INVERT: begin
                z = ~x;
                next_state = S_INVERT;
            end

            default: begin
                z = 0;
                next_state = S_WAIT;
            end
        endcase
    end

endmodule
