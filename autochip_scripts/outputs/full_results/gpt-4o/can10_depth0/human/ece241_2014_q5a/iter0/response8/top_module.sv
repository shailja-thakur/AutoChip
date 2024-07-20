module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

    reg [1:0] state, next_state;

    // State encoding
    parameter S_IDLE = 2'b00, 
              S_ONE = 2'b01, 
              S_ZERO = 2'b10, 
              S_DONE = 2'b11;

    // State transition
    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case(state)
            S_IDLE: next_state = S_ONE;
            S_ONE:  next_state = S_ZERO;
            S_ZERO: next_state = S_DONE;
            S_DONE: next_state = S_DONE;
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if(areset)
            z <= 0;
        else begin
            case(state)
                S_IDLE: z <= 0;
                S_ONE:  z <= ~x;     // First inversion (1's complement)
                S_ZERO: z <= x;      // Pass x directly as 2's complement flip
                S_DONE: z <= 0;      // Completion state, output zero
                default: z <= 0;
            endcase
        end
    end

endmodule
