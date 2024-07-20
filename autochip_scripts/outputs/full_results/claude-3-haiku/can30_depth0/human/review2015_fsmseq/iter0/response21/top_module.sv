module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states
localparam STATE_IDLE = 0;
localparam STATE_FOUND_1 = 1;
localparam STATE_FOUND_11 = 2;
localparam STATE_FOUND_110 = 3;
localparam STATE_FOUND_1101 = 4;

// Declare the state register
reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        start_shifting <= 0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (data == 1) begin
                    state <= STATE_FOUND_1;
                end
                else begin
                    state <= STATE_IDLE;
                end
                start_shifting <= 0;
            end
            STATE_FOUND_1: begin
                if (data == 1) begin
                    state <= STATE_FOUND_11;
                end
                else begin
                    state <= STATE_IDLE;
                end
                start_shifting <= 0;
            end
            STATE_FOUND_11: begin
                if (data == 0) begin
                    state <= STATE_FOUND_110;
                end
                else begin
                    state <= STATE_IDLE;
                end
                start_shifting <= 0;
            end
            STATE_FOUND_110: begin
                if (data == 1) begin
                    state <= STATE_FOUND_1101;
                end
                else begin
                    state <= STATE_IDLE;
                end
                start_shifting <= 0;
            end
            STATE_FOUND_1101: begin
                state <= STATE_FOUND_1101;
                start_shifting <= 1;
            end
            default: begin
                state <= STATE_IDLE;
                start_shifting <= 0;
            end
        endcase
    end
end

endmodule
