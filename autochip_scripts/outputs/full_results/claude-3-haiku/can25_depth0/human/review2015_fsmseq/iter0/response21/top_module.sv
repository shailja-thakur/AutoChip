module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter IDLE = 2'b00;
parameter SEARCH_1 = 2'b01;
parameter SEARCH_0 = 2'b10;
parameter FOUND = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (data == 1'b1)
                next_state = SEARCH_1;
            else
                next_state = IDLE;
            start_shifting = 0;
        end
        SEARCH_1: begin
            if (data == 1'b1)
                next_state = SEARCH_0;
            else
                next_state = IDLE;
            start_shifting = 0;
        end
        SEARCH_0: begin
            if (data == 1'b0)
                next_state = SEARCH_1;
            else
                next_state = IDLE;
            start_shifting = 0;
        end
        FOUND: begin
            next_state = FOUND;
            start_shifting = 1;
        end
        default: begin
            next_state = IDLE;
            start_shifting = 0;
        end
    endcase
end

endmodule
