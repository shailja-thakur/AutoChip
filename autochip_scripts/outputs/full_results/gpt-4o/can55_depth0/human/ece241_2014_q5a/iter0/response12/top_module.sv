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
    reg add_one;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always_comb begin
        z = 1'b0; // default output value
        next_state = state; // default next state
        add_one = 1'b0; // default value for add_one

        case (state)
            S_IDLE: begin
                next_state = S_INVERT;
            end

            S_INVERT: begin
                z = ~x;
                next_state = S_ADDONE;
            end

            S_ADDONE: begin
                if (add_one) begin
                    z = ~x + 1;
                    add_one = 1'b0;
                end else begin
                    z = ~x;
                end
                add_one = x ? 1'b1 : 1'b0;
            end

            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

endmodule
