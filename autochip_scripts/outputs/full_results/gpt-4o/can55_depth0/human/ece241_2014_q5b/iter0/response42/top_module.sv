module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    typedef enum logic [1:0] {
        S_A = 2'b01,
        S_B = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S_A: if (x) begin
                     next_state = S_B;
                     z = 1;
                 end else begin
                     next_state = S_A;
                     z = 0;
                 end
            S_B: if (x) begin
                     next_state = S_B;
                     z = 0;
                 end else begin
                     next_state = S_B;
                     z = 1;
                 end
            default: begin
                next_state = S_A;
                z = 0;
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_A;
        else
            state <= next_state;
    end

endmodule
