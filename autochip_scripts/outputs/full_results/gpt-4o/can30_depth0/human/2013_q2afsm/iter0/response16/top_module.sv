module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

// State encoding
typedef enum reg [1:0] {
    STATE_A = 2'd0,
    STATE_B = 2'd1,
    STATE_C = 2'd2,
    STATE_D = 2'd3
} state_t;

state_t state, next_state;

// State flip-flops (sequential logic)
always @(posedge clk) begin
    if (!resetn)
        state <= STATE_A; // Reset to state A
    else
        state <= next_state;
end

// State table (combinational logic)
always @(*) begin
    case (state)
        STATE_A: begin
            if (r[1])
                next_state = STATE_B;
            else if (r[2])
                next_state = STATE_C;
            else if (r[3])
                next_state = STATE_D;
            else
                next_state = STATE_A;
        end
        
        STATE_B: begin
            if (r[1])
                next_state = STATE_B;
            else
                next_state = STATE_A;
        end
        
        STATE_C: begin
            if (r[2])
                next_state = STATE_C;
            else
                next_state = STATE_A;
        end
        
        STATE_D: begin
            next_state = STATE_A; // Always go back to A from D as per no request is 0
        end
        
        default: next_state = STATE_A; // Default state
    endcase
end

// Output logic
always @(*) begin
    g = 3'b000; // Default all grants to 0
    case (state)
        STATE_B: g[1] = 1;
        STATE_C: g[2] = 1;
        STATE_D: g[3] = 1;
    endcase
end

endmodule
