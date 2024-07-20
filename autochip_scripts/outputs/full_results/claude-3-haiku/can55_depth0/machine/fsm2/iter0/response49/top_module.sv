module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// Define the states
localparam [0:0] STATE_A = 1'b0;
localparam [0:0] STATE_B = 1'b1;

// Internal state variable
reg [0:0] state, next_state;

// Combinational logic for next state
always @(*) begin
    case (state)
        STATE_A: next_state = (j) ? STATE_B : STATE_A;
        STATE_B: next_state = (k) ? STATE_A : STATE_B;
        default: next_state = STATE_A;
    endcase
end

// Sequential logic for state update
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_A;
    end
    else begin
        state <= next_state;
    end
end

// Combinational logic for output
always @(*) begin
    out = (state == STATE_B);
end

endmodule
