module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {S0, S1} state_t;
    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            S0: begin
                if (x == 1'b1) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
                z = x;
            end
            S1: begin
                next_state = S1;
                z = ~x;
            end
            default: begin
                next_state = S0;
                z = x;
            end
        endcase
    end

endmodule
