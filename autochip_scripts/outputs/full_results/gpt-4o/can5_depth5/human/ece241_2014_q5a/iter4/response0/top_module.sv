module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Declaration
    typedef enum reg {
        INITIAL = 1'b0, // Initial state, waiting for the first 1 to start flipping
        FLIP = 1'b1     // Flipping bits state
    } state_t;

    // State variables
    state_t state, next_state;
    reg flipped; // An indicator to start flipping after the first 1 is encountered

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= INITIAL;
            flipped <= 1'b0;
        end else begin
            state <= next_state;
            if (state == FLIP) begin
                flipped <= 1'b1;
            end
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            INITIAL: begin
                if (x == 1'b1) begin
                    next_state = FLIP;
                end else begin
                    next_state = INITIAL;
                end
            end
            FLIP: next_state = FLIP;
            default: next_state = INITIAL;
        endcase
    end

    // Sequential logic for output and other operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
        end else begin
            case (state)
                INITIAL: z <= x;   // If in the initial state and received 0, output 0
                FLIP: z <= ~x;     // Complement the incoming bit after the first 1
            endcase
            if (!flipped && state == INITIAL) begin
                z <= x;
            end 
        end
    end

endmodule
