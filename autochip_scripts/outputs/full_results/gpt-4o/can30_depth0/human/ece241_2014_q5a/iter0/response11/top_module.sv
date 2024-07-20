module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        IDLE,           // Waiting for reset release
        FLIP_BITS,      // State for flipping the bits
        ADD_ONE         // State for adding 1 to flip result
    } state_t;

    state_t state, next_state;
    reg carry;          // Carry bit for adding one

    // State transition logic (combinational)
    always_comb begin
        case(state)
            IDLE: begin
                if (!areset)
                    next_state = FLIP_BITS;
                else
                    next_state = IDLE;
            end
            FLIP_BITS: begin
                if (areset)
                    next_state = IDLE;
                else
                    next_state = ADD_ONE;
            end
            ADD_ONE: begin
                if (areset)
                    next_state = IDLE;
                else
                    next_state = FLIP_BITS;   // back to flipping bits for next input
            end
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops (sequential)
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state  <= IDLE;
            carry  <= 1'b0;
            z      <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Output logic (combinational)
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            carry <= 1'b0;
            z     <= 1'b0;
        end else begin
            case(state)
                IDLE: begin
                    z     <= 1'b0;
                    carry <= 1'b0;
                end
                FLIP_BITS: begin
                    z  <= ~x;
                    carry <= 1'b0;
                end
                ADD_ONE: begin
                    z  <= (next_state == ADD_ONE) ? ~x : ~x ^ carry;
                    carry <= (next_state == ADD_ONE) ? 1'b1 : carry & carry;
                end
            endcase
        end
    end

endmodule
