module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'b00,
                 LOOK1 = 2'b01,
                 LOOK101 = 2'b10,
                 FOUND = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (data == 1'b1)
                next_state = LOOK1;
            else
                next_state = IDLE;
            start_shifting = 1'b0;
        end
        LOOK1: begin
            if (data == 1'b0)
                next_state = LOOK101;
            else
                next_state = LOOK1;
            start_shifting = 1'b0;
        end
        LOOK101: begin
            if (data == 1'b1)
                next_state = FOUND;
            else
                next_state = IDLE;
            start_shifting = 1'b0;
        end
        FOUND: begin
            next_state = FOUND;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = IDLE;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
