module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter WAIT = 2'b00, FOUND1 = 2'b01, FOUND11 = 2'b10, FOUND110 = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT;
        start_shifting <= 0;
    end
    else begin
        state <= next_state;
        if (state == FOUND110) begin
            start_shifting <= 1;
        end
    end
end

always @(*) begin
    case (state)
        WAIT:
            if (data == 1)
                next_state = FOUND1;
            else
                next_state = WAIT;
        FOUND1:
            if (data == 1)
                next_state = FOUND11;
            else
                next_state = WAIT;
        FOUND11:
            if (data == 0)
                next_state = FOUND110;
            else
                next_state = WAIT;
        FOUND110:
            next_state = FOUND110;
        default:
            next_state = WAIT;
    endcase
end

endmodule
