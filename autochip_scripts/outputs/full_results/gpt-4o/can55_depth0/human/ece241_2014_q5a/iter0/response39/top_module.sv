module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] { 
        IDLE = 2'b00, 
        INVERT = 2'b01, 
        ADD_ONE = 2'b10 
    } state_t;

    state_t state, next_state;
    reg carry;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
            carry <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                z = 1'b0;
                if (!areset) begin
                    next_state = INVERT;
                end else begin
                    next_state = IDLE;
                end
            end
            INVERT: begin
                z = ~x;
                if (x == 1'b0) begin
                    next_state = INVERT;
                end else begin
                    next_state = ADD_ONE;
                end
            end
            ADD_ONE: begin
                z = x ^ carry;
                carry = carry & x;
                if (x == 1'b0) begin
                    next_state = ADD_ONE;
                end else begin
                    next_state = INVERT;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
