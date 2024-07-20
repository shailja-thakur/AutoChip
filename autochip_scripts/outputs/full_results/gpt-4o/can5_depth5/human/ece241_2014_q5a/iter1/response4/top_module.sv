module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State declaration
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        FLIP = 2'b01,
        INVERT = 2'b10
    } state_t;

    // Current state and next state variables
    state_t state, next_state;

    // Flip-flop to keep track of whether we have started the 2's complement process
    reg flip;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
            flip <= 1'b0;
            z <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            IDLE: begin
                if (x == 1'b1) // Start inverting when first 1 is detected
                    next_state = INVERT;
                else
                    next_state = FLIP;
            end
            FLIP: next_state = (x == 1'b1) ? INVERT : FLIP;
            INVERT: next_state = INVERT;
            default: next_state = IDLE;
        endcase
    end

    // Combinational logic for output
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
            flip <= 1'b0;
        end else begin
            case (next_state)
                IDLE: begin
                    z <= 1'b0;
                    flip <= 1'b0;
                end
                FLIP: begin
                    z <= x;
                    flip <= 1'b0;
                end
                INVERT: begin
                    z <= ~x;
                    flip <= 1'b1;
                end
            endcase
        end
    end
endmodule
