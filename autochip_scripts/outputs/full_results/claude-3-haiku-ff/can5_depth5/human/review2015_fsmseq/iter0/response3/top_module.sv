module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam STATE_0 = 2'b00;
localparam STATE_1 = 2'b01;
localparam STATE_2 = 2'b10;
localparam STATE_3 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_0;
        start_shifting <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_0: begin
            if (data == 1'b1)
                next_state = STATE_1;
            else
                next_state = STATE_0;
        end
        STATE_1: begin
            if (data == 1'b0)
                next_state = STATE_2;
            else
                next_state = STATE_0;
        end
        STATE_2: begin
            if (data == 1'b1)
                next_state = STATE_3;
            else
                next_state = STATE_0;
        end
        STATE_3: begin
            if (data == 1'b1)
                next_state = STATE_3;
            else
                next_state = STATE_0;
            start_shifting <= 1'b1;
        end
        default: begin
            next_state = STATE_0;
            start_shifting <= 1'b0;
        end
    endcase
end

endmodule
