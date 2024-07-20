module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// State encoding
typedef enum reg [1:0] {
    IDLE = 2'b00,
    S1   = 2'b01,
    S10  = 2'b10
} state_t;

state_t state, next_state;

// State transition logic (combinational)
always @(*) begin
    case (state)
        IDLE: if (x) next_state = S1; else next_state = IDLE;
        S1: if (!x) next_state = S10; else next_state = S1;
        S10: if (x) next_state = IDLE; else next_state = IDLE;
        default: next_state = IDLE; 
    endcase
end

// Output logic and state register updates (sequential)
always @(negedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= IDLE;
    else
        state <= next_state;
end

// Output signal z logic
always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        z <= 1'b0;
    else if (state == S10 && x)
        z <= 1'b1;
    else
        z <= 1'b0;
end

endmodule
