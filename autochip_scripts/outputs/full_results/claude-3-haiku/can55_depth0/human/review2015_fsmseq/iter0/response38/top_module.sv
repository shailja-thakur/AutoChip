module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states
localparam STATE_INIT = 2'b00;
localparam STATE_FOUND_1 = 2'b01;
localparam STATE_FOUND_11 = 2'b10;
localparam STATE_FOUND_1101 = 2'b11;

// Declare state register
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_INIT;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            STATE_INIT: begin
                if (data == 1'b1) begin
                    state <= STATE_FOUND_1;
                end
                else begin
                    state <= STATE_INIT;
                end
                start_shifting <= 1'b0;
            end
            STATE_FOUND_1: begin
                if (data == 1'b1) begin
                    state <= STATE_FOUND_11;
                end
                else begin
                    state <= STATE_INIT;
                end
                start_shifting <= 1'b0;
            end
            STATE_FOUND_11: begin
                if (data == 1'b0) begin
                    state <= STATE_FOUND_1101;
                end
                else begin
                    state <= STATE_FOUND_1;
                end
                start_shifting <= 1'b0;
            end
            STATE_FOUND_1101: begin
                if (data == 1'b1) begin
                    state <= STATE_FOUND_1;
                end
                else begin
                    state <= STATE_INIT;
                end
                start_shifting <= 1'b1;
            end
            default: begin
                state <= STATE_INIT;
                start_shifting <= 1'b0;
            end
        endcase
    end
end

endmodule
