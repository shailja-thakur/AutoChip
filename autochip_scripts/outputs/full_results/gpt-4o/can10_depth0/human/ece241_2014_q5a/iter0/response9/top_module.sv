module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S_IDLE = 2'b00,
        S_INVERT = 2'b01,
        S_ADDONE = 2'b10
    } state_t;

    state_t state, next_state;
    reg carry;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S_IDLE: begin
                if (~areset) next_state = S_INVERT;
                else next_state = S_IDLE;
            end
            S_INVERT: next_state = S_ADDONE;
            S_ADDONE: next_state = S_ADDONE;
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
            carry <= 0;
        end else begin
            case (state)
                S_IDLE: begin
                    z <= 0;
                    carry <= 1;  // Set carry to 1 for add one operation
                end
                S_INVERT: begin
                    z <= ~x;
                end
                S_ADDONE: begin
                    {carry, z} <= x + carry;
                end
                default: begin
                    z <= 0;
                    carry <= 0;
                end
            endcase
        end
    end

endmodule
