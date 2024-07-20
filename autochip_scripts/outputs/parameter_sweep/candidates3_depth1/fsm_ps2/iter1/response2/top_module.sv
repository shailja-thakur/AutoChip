module top_module (
    input wire clk,
    input wire [7:0] in,
    input wire reset,
    output wire done
);

// Define the states
typedef enum logic [1:0] {
    IDLE,
    BYTE1,
    BYTE2,
    BYTE3
} state_t;

reg [1:0] state, next_state;

// Assign the next state logic
always_comb begin
    next_state = state;
    case(state)
        IDLE:
            if (in[3] == 1)
                next_state = BYTE1;
        
        BYTE1:
            next_state = BYTE2;
        
        BYTE2:
            next_state = BYTE3;
        
        BYTE3:
            next_state = IDLE;
    endcase
end

// Assign the state transition
always_ff @(posedge clk or posedge reset) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Assign the output signals
assign done = (state == BYTE3);

endmodule
