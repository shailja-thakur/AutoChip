module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

    // State declaration
    typedef enum logic [1:0] {
        IDLE,      // Idle state (waiting for reset)
        INVERT,    // Inverting bits
        ADD_ONE    // Adding one to the result
    } state_t;

    state_t current_state, next_state;
    reg carry; // To handle the carry for 'adding one' part

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state logic and output
    always @(*) begin
        // Default assignments
        next_state = current_state;
        z = 0;

        case (current_state)
            IDLE: begin
                if (!areset) 
                    next_state = INVERT;
            end

            INVERT: begin
                z = ~x;
                next_state = ADD_ONE;
            end

            ADD_ONE: begin
                if (carry) begin
                    z = ~x;
                    carry = x;
                end else begin
                    z = ~x + 1;
                    carry = 1'b0; // No carry needed after first addition
                end
                next_state = INVERT;
            end
        endcase
    end

    // Reset carry on asynchronous reset
    always @(posedge areset) begin
        carry <= 0;
    end

endmodule
