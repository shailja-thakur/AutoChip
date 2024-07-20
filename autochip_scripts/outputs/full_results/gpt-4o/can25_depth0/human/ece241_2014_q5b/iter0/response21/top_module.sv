module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    typedef enum logic [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition and output logic
    always @(*) begin
        case (state)
            A: begin
                z = x;
                next_state = x ? B : A;
            end
            B: begin
                z = ~x;
                next_state = B; // B state remains B regardless of input x
            end
            default: begin
                z = 0;
                next_state = A;
            end
        endcase
    end
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
