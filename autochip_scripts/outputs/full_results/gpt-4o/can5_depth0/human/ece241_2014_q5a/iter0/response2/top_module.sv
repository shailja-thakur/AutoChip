module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Encoding
    typedef enum reg [1:0] {
        STATE_INIT    = 2'b00,
        STATE_FLOP0   = 2'b01,
        STATE_FLOP1   = 2'b10
    } state_t;

    state_t state, next_state;
    reg carry; // To track the carry from the addition required for 2's complement

    // State Transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_INIT;
        else
            state <= next_state;
    end

    // Next State Logic
    always_comb begin
        case (state)
            STATE_INIT: begin
                if (areset)
                    next_state = STATE_INIT;
                else
                    next_state = STATE_FLOP0;
            end
            STATE_FLOP0: begin
                next_state = STATE_FLOP1;
            end
            STATE_FLOP1: begin
                next_state = STATE_FLOP1;
            end
            default: next_state = STATE_INIT;
        endcase
    end

    // Output Logic and Carry Update
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
            carry <= 1'b1; // As we start with LSB, initial carry would be 1 for 2's complementing
        end
        else begin
            case (state)
                STATE_INIT: begin
                    z <= 1'b0;
                    carry <= 1'b1;
                end
                STATE_FLOP0: begin
                    // Flop state before calculating actual value
                end
                STATE_FLOP1: begin
                    z <= x ^ carry; // XOR with carry to get 2's complement bit
                    carry <= x & carry; // Update carry
                end
            endcase
        end
    end

endmodule
