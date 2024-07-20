module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg [1:0] {OFF = 2'd0, ON = 2'd1} state_t;
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            OFF: if (j) next_state = ON;
                 else next_state = OFF;
            ON:  if (k) next_state = OFF;
                 else next_state = ON;
            default: next_state = OFF; // Safe default state
        endcase
    end

    // State flip-flops with synchronous reset (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic (Moore output, depends only on the state)
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0;
        else
            out <= (state == ON);
    end
endmodule
