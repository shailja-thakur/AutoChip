module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states
localparam [1:0] WAIT_1 = 2'b00,
                 WAIT_10 = 2'b01,
                 WAIT_101 = 2'b10,
                 FOUND_1101 = 2'b11;

// Initialize the state register
reg [1:0] state, next_state;

// State transition logic
always @(posedge clk) begin
    if (reset)
        state <= WAIT_1;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        WAIT_1: begin
            if (data == 1'b1)
                next_state = WAIT_10;
            else
                next_state = WAIT_1;
        end
        WAIT_10: begin
            if (data == 1'b0)
                next_state = WAIT_101;
            else
                next_state = WAIT_1;
        end
        WAIT_101: begin
            if (data == 1'b1)
                next_state = FOUND_1101;
            else
                next_state = WAIT_1;
        end
        FOUND_1101: begin
            next_state = FOUND_1101;
        end
        default:
            next_state = WAIT_1;
    endcase
end

// Output logic
always @(posedge clk) begin
    if (reset)
        start_shifting <= 1'b0;
    else if (state == FOUND_1101)
        start_shifting <= 1'b1;
end

endmodule
