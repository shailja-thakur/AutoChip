module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// Define the states
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

// Define the state register
reg [1:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        STATE_A: begin
            if (in == 1'b0) next_state = STATE_A;
            else next_state = STATE_B;
        end
        STATE_B: begin
            if (in == 1'b0) next_state = STATE_C;
            else next_state = STATE_B;
        end
        STATE_C: begin
            if (in == 1'b0) next_state = STATE_A;
            else next_state = STATE_D;
        end
        STATE_D: begin
            if (in == 1'b0) next_state = STATE_C;
            else next_state = STATE_B;
        end
    endcase
end

// Output logic
always @(*) begin
    if (state == STATE_D) out = 1'b1;
    else out = 1'b0;
end

// State register update
always @(posedge clk, posedge areset) begin
    if (areset) state <= STATE_A;
    else state <= next_state;
end

endmodule
