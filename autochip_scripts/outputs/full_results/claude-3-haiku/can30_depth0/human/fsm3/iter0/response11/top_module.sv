module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

localparam [1:0] 
    STATE_A = 2'b00,
    STATE_B = 2'b01,
    STATE_C = 2'b10,
    STATE_D = 2'b11;

// State transition logic
always @(*) begin
    case (state)
        STATE_A: next_state = (in) ? STATE_B : STATE_A;
        STATE_B: next_state = (in) ? STATE_B : STATE_C;
        STATE_C: next_state = (in) ? STATE_D : STATE_A;
        STATE_D: next_state = (in) ? STATE_B : STATE_C;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        STATE_D: out = 1'b1;
        default: out = 1'b0;
    endcase
end

// State register
always @(posedge clk, posedge areset) begin
    if (areset)
        state <= STATE_A;
    else
        state <= next_state;
end

endmodule
