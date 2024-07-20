module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter STATE_0 = 3'd0;
parameter STATE_1 = 3'd1;
parameter STATE_2 = 3'd2;
parameter STATE_3 = 3'd3;
parameter STATE_4 = 3'd4;

reg [2:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_0;
        start_shifting <= 1'b0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_0: begin
            if (data == 1'b1) begin
                next_state = STATE_1;
            end
            else begin
                next_state = STATE_0;
            end
            start_shifting = 1'b0;
        end
        STATE_1: begin
            if (data == 1'b1) begin
                next_state = STATE_2;
            end
            else begin
                next_state = STATE_0;
            end
            start_shifting = 1'b0;
        end
        STATE_2: begin
            if (data == 1'b0) begin
                next_state = STATE_3;
            end
            else begin
                next_state = STATE_0;
            end
            start_shifting = 1'b0;
        end
        STATE_3: begin
            if (data == 1'b1) begin
                next_state = STATE_4;
            end
            else begin
                next_state = STATE_0;
            end
            start_shifting = 1'b0;
        end
        STATE_4: begin
            next_state = STATE_4;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = STATE_0;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
