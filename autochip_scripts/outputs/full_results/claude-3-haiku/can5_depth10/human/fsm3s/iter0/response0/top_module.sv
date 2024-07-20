module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

// State encoding
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

// State transition logic
always @(state, in) begin
    case (state)
        STATE_A: next_state = (in == 1'b0) ? STATE_A : STATE_B;
        STATE_B: next_state = (in == 1'b0) ? STATE_C : STATE_B;
        STATE_C: next_state = (in == 1'b0) ? STATE_A : STATE_D;
        STATE_D: next_state = (in == 1'b0) ? STATE_C : STATE_B;
    endcase
end

// Output logic
always @(state) begin
    case (state)
        STATE_A, STATE_B, STATE_C: out = 1'b0;
        STATE_D: out = 1'b1;
    endcase
end

// State register
always @(posedge clk, posedge reset) begin
    if (reset)
        state <= STATE_A;
    else
        state <= next_state;
end

endmodule
