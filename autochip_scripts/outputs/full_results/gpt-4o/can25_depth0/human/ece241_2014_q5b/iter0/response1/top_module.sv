module top_module (
    input clk,
    input areset,  // asynchronous reset
    input x,
    output reg z
);

    // State declaration using one-hot encoding
    typedef enum reg [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (x) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = A;
                    z = 0;
                end
            B: if (x) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
