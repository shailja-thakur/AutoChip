module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] 
    STATE_INIT = 2'b00,
    STATE_FOUND_1 = 2'b01,
    STATE_FOUND_11 = 2'b10,
    STATE_FOUND_110 = 2'b11;

reg [1:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_INIT;
        start_shifting <= 1'b0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_INIT: begin
            if (data == 1'b1) begin
                next_state = STATE_FOUND_1;
            end
            else begin
                next_state = STATE_INIT;
            end
            start_shifting = 1'b0;
        end
        STATE_FOUND_1: begin
            if (data == 1'b1) begin
                next_state = STATE_FOUND_11;
            end
            else begin
                next_state = STATE_INIT;
            end
            start_shifting = 1'b0;
        end
        STATE_FOUND_11: begin
            if (data == 1'b0) begin
                next_state = STATE_FOUND_110;
            end
            else begin
                next_state = STATE_INIT;
            end
            start_shifting = 1'b0;
        end
        STATE_FOUND_110: begin
            if (data == 1'b1) begin
                next_state = STATE_FOUND_110;
                start_shifting = 1'b1;
            end
            else begin
                next_state = STATE_INIT;
                start_shifting = 1'b0;
            end
        end
        default: begin
            next_state = STATE_INIT;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
