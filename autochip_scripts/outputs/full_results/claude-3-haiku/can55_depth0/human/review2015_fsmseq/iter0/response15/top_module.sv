module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states of the FSM
parameter STATE_IDLE = 3'b000;
parameter STATE_SEARCH_1 = 3'b001;
parameter STATE_SEARCH_10 = 3'b010;
parameter STATE_SEARCH_101 = 3'b011;
parameter STATE_FOUND = 3'b100;

// Declare the current and next state registers
reg [2:0] current_state, next_state;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_IDLE;
    end else begin
        current_state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        STATE_IDLE: begin
            if (data == 1'b1) begin
                next_state = STATE_SEARCH_1;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_SEARCH_1: begin
            if (data == 1'b1) begin
                next_state = STATE_SEARCH_10;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_SEARCH_10: begin
            if (data == 1'b0) begin
                next_state = STATE_SEARCH_101;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_SEARCH_101: begin
            if (data == 1'b1) begin
                next_state = STATE_FOUND;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_FOUND: begin
            next_state = STATE_FOUND;
        end
        default: begin
            next_state = STATE_IDLE;
        end
    endcase
end

// Output logic
always @(posedge clk) begin
    if (reset) begin
        start_shifting <= 1'b0;
    end else if (current_state == STATE_FOUND) begin
        start_shifting <= 1'b1;
    end
end

endmodule
