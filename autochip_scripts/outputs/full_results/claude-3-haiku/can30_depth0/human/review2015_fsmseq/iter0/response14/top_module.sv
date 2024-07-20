module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states
localparam STATE_IDLE = 3'd0;
localparam STATE_FOUND_1 = 3'd1;
localparam STATE_FOUND_10 = 3'd2;
localparam STATE_FOUND_101 = 3'd3;
localparam STATE_FOUND_1101 = 3'd4;

// Declare the state register
reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (data == 1'b1) begin
                    state <= STATE_FOUND_1;
                end
                else begin
                    state <= STATE_IDLE;
                end
                start_shifting <= 1'b0;
            end
            STATE_FOUND_1: begin
                if (data == 1'b0) begin
                    state <= STATE_FOUND_10;
                end
                else begin
                    state <= STATE_IDLE;
                end
                start_shifting <= 1'b0;
            end
            STATE_FOUND_10: begin
                if (data == 1'b1) begin
                    state <= STATE_FOUND_101;
                end
                else begin
                    state <= STATE_IDLE;
                end
                start_shifting <= 1'b0;
            end
            STATE_FOUND_101: begin
                if (data == 1'b0) begin
                    state <= STATE_FOUND_1101;
                end
                else begin
                    state <= STATE_IDLE;
                end
                start_shifting <= 1'b0;
            end
            STATE_FOUND_1101: begin
                state <= STATE_FOUND_1101;
                start_shifting <= 1'b1;
            end
            default: begin
                state <= STATE_IDLE;
                start_shifting <= 1'b0;
            end
        endcase
    end
end

endmodule
