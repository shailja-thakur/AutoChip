module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] 
    WAIT_FOR_1 = 2'b00,
    WAIT_FOR_0 = 2'b01,
    WAIT_FOR_1_AGAIN = 2'b10,
    FOUND_SEQUENCE = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_1;
        start_shifting <= 0;
    end
    else begin
        state <= next_state;
        if (state == FOUND_SEQUENCE)
            start_shifting <= 1;
    end
end

always @(*) begin
    case (state)
        WAIT_FOR_1: begin
            if (data == 1'b1)
                next_state = WAIT_FOR_0;
            else
                next_state = WAIT_FOR_1;
        end
        WAIT_FOR_0: begin
            if (data == 1'b0)
                next_state = WAIT_FOR_1_AGAIN;
            else
                next_state = WAIT_FOR_0;
        end
        WAIT_FOR_1_AGAIN: begin
            if (data == 1'b1)
                next_state = FOUND_SEQUENCE;
            else
                next_state = WAIT_FOR_1;
        end
        FOUND_SEQUENCE: begin
            next_state = FOUND_SEQUENCE;
        end
        default: begin
            next_state = WAIT_FOR_1;
        end
    endcase
end

endmodule
