module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define state encoding
    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            OFF: if (j) next_state = ON;
                 else next_state = OFF;
            ON:  if (k) next_state = OFF;
                 else next_state = ON;
            default: next_state = OFF;
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic (based on state)
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b0;
        else
            out <= (state == ON);
    end

endmodule
