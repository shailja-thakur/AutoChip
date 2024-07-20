module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
parameter IDLE = 0, CONVERT = 1;
reg state, next_state;

// Register to hold the running 2's complement value
reg [7:0] result;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        result <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        result <= result >> 1;
        result[7] <= x;
        z <= ~result[0];
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (~areset) begin
                next_state = CONVERT;
            end
        end
        CONVERT: begin
            if (areset) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
