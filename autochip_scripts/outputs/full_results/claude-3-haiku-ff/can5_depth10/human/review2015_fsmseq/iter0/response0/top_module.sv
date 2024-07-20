module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states of the finite-state machine
parameter STATE_IDLE = 3'b000;
parameter STATE_FOUND_1 = 3'b001;
parameter STATE_FOUND_10 = 3'b010;
parameter STATE_FOUND_101 = 3'b011;
parameter STATE_FOUND_1101 = 3'b100;

// Declare the current state register
reg [2:0] current_state, next_state;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= STATE_IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        current_state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        STATE_IDLE: begin
            if (data == 1'b1) begin
                next_state = STATE_FOUND_1;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_FOUND_1: begin
            if (data == 1'b0) begin
                next_state = STATE_FOUND_10;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_FOUND_10: begin
            if (data == 1'b1) begin
                next_state = STATE_FOUND_101;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_FOUND_101: begin
            if (data == 1'b0) begin
                next_state = STATE_FOUND_1101;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_FOUND_1101: begin
            next_state = STATE_FOUND_1101;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = STATE_IDLE;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
