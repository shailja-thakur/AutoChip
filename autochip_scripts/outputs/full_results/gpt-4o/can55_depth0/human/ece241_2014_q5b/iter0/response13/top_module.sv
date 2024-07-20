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

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    always_comb begin
        case (state)
            A: begin
                z = x;
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                z = ~x;
                next_state = B;
            end
            default: begin
                z = 0;
                next_state = A;
            end
        endcase
    end
endmodule
