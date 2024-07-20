module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states
parameter IDLE   = 2'b00;
parameter SEARCH = 2'b01;
parameter FOUND  = 2'b11;

// Internal variables
reg [1:0] state, next_state;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = SEARCH;
            end
            else begin
                next_state = IDLE;
            end
        end
        SEARCH: begin
            if (data == 1'b0) begin
                next_state = SEARCH;
            end
            else if (data == 1'b1) begin
                next_state = FOUND;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND: begin
            next_state = FOUND;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Output logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        start_shifting <= 1'b0;
    end
    else if (state == FOUND) begin
        start_shifting <= 1'b1;
    end
end

endmodule
