module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        COMPUTE = 2'b01,
        FLIP = 2'b10,
        ADD_ONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg add_bit;
    reg flip_bit;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                z = 0;
                add_bit = 0;
                flip_bit = 0;
                next_state = areset ? IDLE : COMPUTE;
            end
            
            COMPUTE: begin
                if (areset) begin
                    next_state = IDLE;
                    z = 0;
                    add_bit = 0;
                    flip_bit = 0;
                end else begin
                    next_state = (add_bit) ? ADD_ONE : FLIP;
                    z = (flip_bit) ? ~x : x;
                    flip_bit = ~x;
                end
            end
            
            FLIP: begin
                next_state = (areset) ? IDLE : ADD_ONE;
                z = x;
            end
            
            ADD_ONE: begin
                if (areset) begin
                    next_state = IDLE;
                    z = 0;
                    add_bit = 0;
                    flip_bit = 0;
                end else begin
                    z = ~x;
                    add_bit = 1;
                end
            end
            
            default: begin
                next_state = IDLE;
                z = 0;
                add_bit = 0;
                flip_bit = 0;
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= IDLE;
        else
            state <= next_state;
    end

endmodule
