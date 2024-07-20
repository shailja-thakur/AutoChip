module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states
localparam STATE_IDLE  = 2'b00;
localparam STATE_FIRST = 2'b01;
localparam STATE_LAST  = 2'b11;

// Declare the state register
reg [1:0] state, next_state;

// Combinational logic for next state
always @(*) begin
    case (state)
        STATE_IDLE: begin
            if (x)
                next_state = STATE_FIRST;
            else
                next_state = STATE_IDLE;
        end
        STATE_FIRST: begin
            if (x)
                next_state = STATE_LAST;
            else
                next_state = STATE_IDLE;
        end
        STATE_LAST: begin
            if (x)
                next_state = STATE_FIRST;
            else
                next_state = STATE_IDLE;
        end
        default: next_state = STATE_IDLE;
    endcase
end

// Combinational logic for output
always @(*) begin
    z = (state == STATE_LAST && x) ? 1'b1 : 1'b0;
end

// Sequential logic for state register
always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= STATE_IDLE;
    else
        state <= next_state;
end

endmodule
