module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

// State encoding
typedef enum reg [1:0] {
    STATE_A = 2'b00,
    STATE_B = 2'b01,
    STATE_C = 2'b10,
    STATE_D = 2'b11
} state_t;

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case(state)
        STATE_A: 
            if (r[1]) next_state = STATE_B;
            else if (r[2]) next_state = STATE_C;
            else if (r[3]) next_state = STATE_D;
            else next_state = STATE_A;
        STATE_B: 
            if (r[1]) next_state = STATE_B;
            else next_state = STATE_A;
        STATE_C: 
            if (r[2]) next_state = STATE_C;
            else next_state = STATE_A;
        STATE_D: 
            if (r[3]) next_state = STATE_D;
            else next_state = STATE_A;
        default: 
            next_state = STATE_A;
    endcase
end

// State update logic
always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= STATE_A;
    else
        state <= next_state;
end

// Output logic
always @(*) begin
    g = 3'b000;
    case(state)
        STATE_B: g[1] = 1'b1;
        STATE_C: g[2] = 1'b1;
        STATE_D: g[3] = 1'b1;
        default: g = 3'b000;
    endcase
end

endmodule
