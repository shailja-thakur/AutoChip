module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter [2:0] WAIT_1 = 3'd0,
                WAIT_10 = 3'd1,
                WAIT_101 = 3'd2,
                FOUND_1101 = 3'd3;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_1;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        WAIT_1: begin
            if (data) begin
                next_state = WAIT_10;
            end
            else begin
                next_state = WAIT_1;
            end
            start_shifting = 0;
        end
        WAIT_10: begin
            if (data) begin
                next_state = WAIT_101;
            end
            else begin
                next_state = WAIT_1;
            end
            start_shifting = 0;
        end
        WAIT_101: begin
            if (~data) begin
                next_state = FOUND_1101;
            end
            else begin
                next_state = WAIT_1;
            end
            start_shifting = 0;
        end
        FOUND_1101: begin
            next_state = FOUND_1101;
            start_shifting = 1;
        end
        default: begin
            next_state = WAIT_1;
            start_shifting = 0;
        end
    endcase
end

endmodule
