module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter WAIT_FOR_1 = 3'd0;
    parameter WAIT_FOR_10 = 3'd1;
    parameter WAIT_FOR_101 = 3'd2;
    parameter FOUND_1101 = 3'd3;

    reg [2:0] current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= WAIT_FOR_1;
            start_shifting <= 1'b0;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            WAIT_FOR_1: begin
                if (data == 1'b1) begin
                    next_state = WAIT_FOR_10;
                end
                else begin
                    next_state = WAIT_FOR_1;
                end
                start_shifting = 1'b0;
            end
            WAIT_FOR_10: begin
                if (data == 1'b0) begin
                    next_state = WAIT_FOR_101;
                end
                else begin
                    next_state = WAIT_FOR_1;
                end
                start_shifting = 1'b0;
            end
            WAIT_FOR_101: begin
                if (data == 1'b1) begin
                    next_state = FOUND_1101;
                end
                else begin
                    next_state = WAIT_FOR_1;
                end
                start_shifting = 1'b0;
            end
            FOUND_1101: begin
                next_state = FOUND_1101;
                start_shifting = 1'b1;
            end
            default: begin
                next_state = WAIT_FOR_1;
                start_shifting = 1'b0;
            end
        endcase
    end

endmodule
