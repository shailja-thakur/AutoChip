module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg {
        ZERO = 1'b0,
        ONE = 1'b1
    } state_t;
    
    reg state, next_state;
    reg complement_started;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= ZERO;
            z <= 0;
            complement_started <= 0;
        end else begin
            state <= next_state;
            complement_started <= 1;
        end
    end

    always @(*) begin
        if (!complement_started) begin
            z = 0;
            next_state = ZERO;
        end else begin
            case (state)
                ZERO: begin
                    if (x) begin
                        next_state = ONE;
                        z = 1;
                    end else begin
                        next_state = ZERO;
                        z = 0;
                    end
                end
                ONE: begin
                    if (x) begin
                        next_state = ONE;
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
    end
endmodule
