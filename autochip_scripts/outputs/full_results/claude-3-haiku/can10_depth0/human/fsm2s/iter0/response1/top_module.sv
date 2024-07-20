module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

// Define the states
localparam STATE_OFF = 1'b0;
localparam STATE_ON = 1'b1;

// Define the current and next state registers
reg current_state, next_state;

// State transition logic
always @(*) begin
    case (current_state)
        STATE_OFF: begin
            if (j) begin
                next_state = STATE_ON;
            end else begin
                next_state = STATE_OFF;
            end
        end
        STATE_ON: begin
            if (k) begin
                next_state = STATE_OFF;
            end else begin
                next_state = STATE_ON;
            end
        end
        default: begin
            next_state = STATE_OFF;
        end
    endcase
end

// Output logic
always @(*) begin
    case (current_state)
        STATE_OFF: begin
            out = 1'b0;
        end
        STATE_ON: begin
            out = 1'b1;
        end
        default: begin
            out = 1'b0;
        end
    endcase
end

// State register update
always @(posedge clk, posedge reset) begin
    if (reset) begin
        current_state <= STATE_OFF;
    end else begin
        current_state <= next_state;
    end
end

endmodule
