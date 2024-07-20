module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot
    typedef enum logic [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;
    
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1;
                end
                else begin
                    next_state = A;
                    z = 0;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                    z = 0;
                end
                else begin
                    next_state = B;
                    z = 1;
                end
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
