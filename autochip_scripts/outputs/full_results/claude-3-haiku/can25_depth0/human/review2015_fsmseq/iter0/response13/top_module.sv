module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states of the finite-state machine
parameter IDLE = 2'b00, MATCH_1 = 2'b01, MATCH_11 = 2'b10, MATCH_101 = 2'b11;

// Register to store the current state
reg [1:0] state;

// Next state logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= MATCH_1;
                end else begin
                    state <= IDLE;
                end
                start_shifting <= 1'b0;
            end
            MATCH_1: begin
                if (data == 1'b1) begin
                    state <= MATCH_11;
                end else begin
                    state <= IDLE;
                end
                start_shifting <= 1'b0;
            end
            MATCH_11: begin
                if (data == 1'b0) begin
                    state <= MATCH_101;
                end else begin
                    state <= IDLE;
                end
                start_shifting <= 1'b0;
            end
            MATCH_101: begin
                if (data == 1'b1) begin
                    state <= MATCH_1;
                    start_shifting <= 1'b1;
                end else begin
                    state <= IDLE;
                    start_shifting <= 1'b0;
                end
            end
            default: begin
                state <= IDLE;
                start_shifting <= 1'b0;
            end
        endcase
    end
end

endmodule
