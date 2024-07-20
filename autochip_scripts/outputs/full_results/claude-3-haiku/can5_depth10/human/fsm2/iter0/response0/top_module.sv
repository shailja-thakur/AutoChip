module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// Define the states
localparam STATE_OFF = 1'b0;
localparam STATE_ON = 1'b1;

// Define the current state register
reg current_state, next_state;

// State transition logic
always @(*) begin
    case (current_state)
        STATE_OFF: begin
            if (j) next_state = STATE_ON;
            else next_state = STATE_OFF;
        end
        STATE_ON: begin
            if (k) next_state = STATE_OFF;
            else next_state = STATE_ON;
        end
        default: next_state = STATE_OFF;
    endcase
end

// Output logic
always @(*) begin
    case (current_state)
        STATE_OFF: out = 1'b0;
        STATE_ON: out = 1'b1;
        default: out = 1'b0;
    endcase
end

// Sequential logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_OFF;
    end else begin
        current_state <= next_state;
    end
end

endmodule
