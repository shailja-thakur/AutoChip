module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

// State encoding
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

always @(*) begin
    case (state)
        STATE_A: next_state = in ? STATE_B : STATE_A;
        STATE_B: next_state = in ? STATE_B : STATE_C;
        STATE_C: next_state = in ? STATE_D : STATE_A;
        STATE_D: next_state = in ? STATE_B : STATE_C;
        default: next_state = STATE_A; // Default case to avoid latches
    endcase
end

always @(*) begin
    out = (state == STATE_D);
end

endmodule
