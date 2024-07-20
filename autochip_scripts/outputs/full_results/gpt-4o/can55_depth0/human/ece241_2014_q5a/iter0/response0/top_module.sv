module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State Encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00, // Wait for reset release
        RECEIVE = 2'b01, // Receiving bits to calculate 2's complement
        FLIP = 2'b10, // Flipping bits after the first 1 is received
        COMPLETE = 2'b11 // Completion state
    } state_t;

    state_t current_state, next_state;
    logic flip; // indicates if the first '1' is seen
    logic bit;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            flip <= 1'b0;
        else if (current_state == RECEIVE && x == 1'b1)
            flip <= 1'b1;
        else
            flip <= flip;
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            bit <= 1'b0;
        else if (current_state == COMPLETE)
            bit <= 1'b0;
        else if (flip)
            bit <= ~x;
        else
            bit <= x;
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (!areset)
                    next_state = RECEIVE;
            end
            RECEIVE: begin
                if (flip)
                    next_state = FLIP;
            end
            FLIP: begin
                if (x == 1'b0)
                    next_state = FLIP;
                else
                    next_state = COMPLETE;
            end
            COMPLETE: begin
                if (areset)
                    next_state = IDLE;
                else
                    next_state = COMPLETE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    assign z = bit;

endmodule
