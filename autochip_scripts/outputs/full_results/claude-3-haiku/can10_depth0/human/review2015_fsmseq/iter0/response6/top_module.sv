module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam INIT = 2'b00, SEARCH_1 = 2'b01, SEARCH_0 = 2'b10, SEARCH_1_1 = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= INIT;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        INIT: begin
            if (data == 1'b1) begin
                next_state = SEARCH_1;
            end else begin
                next_state = INIT;
            end
            start_shifting = 1'b0;
        end
        SEARCH_1: begin
            if (data == 1'b0) begin
                next_state = SEARCH_0;
            end else begin
                next_state = SEARCH_1;
            end
            start_shifting = 1'b0;
        end
        SEARCH_0: begin
            if (data == 1'b1) begin
                next_state = SEARCH_1_1;
            end else begin
                next_state = INIT;
            end
            start_shifting = 1'b0;
        end
        SEARCH_1_1: begin
            if (data == 1'b0) begin
                next_state = INIT;
            end else begin
                next_state = SEARCH_1_1;
            end
            start_shifting = 1'b1;
        end
        default: begin
            next_state = INIT;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
