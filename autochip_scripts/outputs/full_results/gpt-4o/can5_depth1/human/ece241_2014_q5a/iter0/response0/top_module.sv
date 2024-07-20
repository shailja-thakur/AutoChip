module top_module (
	input clk,
	input areset,
	input x,
	output z
);

    // State encoding
    typedef enum reg {IDLE, NEGATE, ADD_ONE} state_t;
    state_t state, next_state;

    // Internal signals
    reg temp_z;

    // Moore machine output logic (depends only on state)
    always @(*) begin
        case (state)
            IDLE:     temp_z = 0;
            NEGATE:   temp_z = ~x;
            ADD_ONE:  temp_z = x;
            default:  temp_z = 0;
        endcase
    end

    // Register to hold the output
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE:     next_state = NEGATE;
            NEGATE:   next_state = ADD_ONE;
            ADD_ONE:  next_state = ADD_ONE;
            default:  next_state = IDLE;
        endcase
    end

    // Output assignment
    assign z = temp_z;

endmodule
