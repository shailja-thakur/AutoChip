module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the state variables
reg [1:0] current_state, next_state;

// Define the states
localparam WAIT_FOR_1 = 2'b00;
localparam FOUND_1 = 2'b01;
localparam FOUND_11 = 2'b10;
localparam FOUND_1101 = 2'b11;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        current_state <= WAIT_FOR_1;
    end
    else begin
        current_state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        WAIT_FOR_1: begin
            if (data == 1'b1) begin
                next_state = FOUND_1;
            end
            else begin
                next_state = WAIT_FOR_1;
            end
        end
        FOUND_1: begin
            if (data == 1'b0) begin
                next_state = FOUND_11;
            end
            else begin
                next_state = WAIT_FOR_1;
            end
        end
        FOUND_11: begin
            if (data == 1'b0) begin
                next_state = FOUND_1101;
            end
            else begin
                next_state = WAIT_FOR_1;
            end
        end
        FOUND_1101: begin
            next_state = FOUND_1101;
        end
        default: begin
            next_state = WAIT_FOR_1;
        end
    endcase
end

// Output logic
always @(posedge clk) begin
    if (reset) begin
        start_shifting <= 1'b0;
    end
    else if (current_state == FOUND_1101) begin
        start_shifting <= 1'b1;
    end
end

endmodule
