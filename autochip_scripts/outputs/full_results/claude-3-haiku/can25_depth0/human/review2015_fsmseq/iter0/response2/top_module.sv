module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] SEARCH_1 = 2'b00,
                 SEARCH_1_0 = 2'b01,
                 SEARCH_1_1_0 = 2'b10,
                 FOUND_1101 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= SEARCH_1;
        start_shifting <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        SEARCH_1: begin
            if (data == 1'b1)
                next_state = SEARCH_1_0;
            else
                next_state = SEARCH_1;
        end
        SEARCH_1_0: begin
            if (data == 1'b0)
                next_state = SEARCH_1_1_0;
            else
                next_state = SEARCH_1;
        end
        SEARCH_1_1_0: begin
            if (data == 1'b1)
                next_state = FOUND_1101;
            else
                next_state = SEARCH_1;
        end
        FOUND_1101: begin
            next_state = FOUND_1101;
            start_shifting <= 1'b1;
        end
        default: begin
            next_state = SEARCH_1;
            start_shifting <= 1'b0;
        end
    endcase
end

endmodule
