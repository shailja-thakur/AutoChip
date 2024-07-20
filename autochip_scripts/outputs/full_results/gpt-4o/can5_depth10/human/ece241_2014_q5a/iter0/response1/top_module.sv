module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        ZERO = 2'b00,
        ONE = 2'b01
    } state_t;
    
    reg state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= ZERO;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            ZERO: begin
                if (x) begin
                    next_state = ONE;
                    z = 1;
                end else begin
                    next_state = state;
                    z = 0;
                end
            end
            ONE: begin
                if (x) begin
                    next_state = state;
                    z = 0;
                end else begin
                    next_state = ONE;
                    z = 1;
                end
            end
            default: begin
                next_state = ZERO;
                z = 0;
            end
        endcase
    end
endmodule
