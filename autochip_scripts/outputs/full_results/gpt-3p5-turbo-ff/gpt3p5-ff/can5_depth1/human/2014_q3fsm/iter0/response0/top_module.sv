module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define the states
typedef enum logic [1:0] {
    STATE_A,
    STATE_B,
    STATE_C,
    STATE_D
} state_t;

// Define the current state variable
reg [1:0] current_state;

// Define the next state variable
reg [1:0] next_state;

// Initialize the state
always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= STATE_A;
    else
        current_state <= next_state;
end

// Determine the next state and output based on the current state and inputs
always @* begin
    case (current_state)
        STATE_A: begin
            if (s)
                next_state = STATE_B;
            else
                next_state = STATE_A;
        end
        STATE_B: begin
            if (w == 2'b11)
                next_state = STATE_C;
            else
                next_state = STATE_B;
        end
        STATE_C: begin
            if (w == 2'b01 || w == 2'b10)
                next_state = STATE_D;
            else
                next_state = STATE_B;
        end
        STATE_D: begin
            next_state = STATE_A;
        end
        default: next_state = STATE_A;
    endcase
    
    if (current_state == STATE_C && (w == 2'b01 || w == 2'b10))
        z = 1;
    else
        z = 0;
end

endmodule
