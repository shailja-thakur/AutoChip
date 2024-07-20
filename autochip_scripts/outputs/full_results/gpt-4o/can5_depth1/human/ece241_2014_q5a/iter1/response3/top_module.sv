module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE        = 2'd0,  // Initial idle state
        STARTED     = 2'd1,  // Start processing
        COMPLEMENT  = 2'd2   // Complementing state
    } state_t;

    state_t state, next_state;

    // State transition on clock edge or asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state <= IDLE;
        else
            state <= next_state;
    end

    // State machine logic
    always_comb begin
        case (state)
            IDLE: begin
                z = 1'b0; // output doesn't matter, default to 0
                if (!areset) 
                    next_state = STARTED;
                else
                    next_state = IDLE;
            end
            
            STARTED: begin
                if (x == 1) begin
                    z = ~x; // start complementing from first 1
                    next_state = COMPLEMENT;
                end else begin
                    z = x; // propagate same bit until 1 is encountered
                    next_state = STARTED;
                end
            end
            
            COMPLEMENT: begin
                z = ~x; // continue complementing
                next_state = COMPLEMENT;
            end
            
            default: begin
                z = 1'b0;
                next_state = IDLE;
            end
        endcase
    end

endmodule
