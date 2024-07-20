module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define state encoding
    typedef enum reg [1:0] {
        START = 2'b00,
        INVERT = 2'b01,
        PASS = 2'b10
    } state_t;
    state_t state, next_state;

    // Output logic: z is controlled directly by the state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= START;
            z <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                START: z <= x;      // Direct pass through
                INVERT: z <= ~x;    // Invert the input
                PASS: z <= x;       // Direct pass through
                default: z <= x;    // Default case
            endcase
        end
    end

    // State transition logic (Moore FSM)
    always @(*) begin
        // Default state remains the same
        next_state = state;
        
        case (state)
            START: begin
                if (x == 1'b1) begin
                    next_state = INVERT; // Start inverting after seeing the first '1'
                end else begin
                    next_state = START;
                end
            end
            INVERT: begin
                if (x == 1'b0) begin
                    next_state = PASS;  // Move to pass-through after the LSB
                end else begin
                    next_state = INVERT;
                end
            end
            PASS: begin
                next_state = PASS; // Pass through the rest
            end
        endcase
    end
endmodule
