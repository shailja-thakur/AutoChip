module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    localparam [3:0] IDLE = 4'd0,
                    SEARCH_1 = 4'd1,
                    SEARCH_1_0 = 4'd2,
                    SEARCH_1_0_1 = 4'd3,
                    FOUND = 4'd4;

    reg [3:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = SEARCH_1;
                end
                else begin
                    next_state = IDLE;
                end
            end
            SEARCH_1: begin
                if (data == 1'b0) begin
                    next_state = SEARCH_1_0;
                end
                else begin
                    next_state = IDLE;
                end
            end
            SEARCH_1_0: begin
                if (data == 1'b1) begin
                    next_state = SEARCH_1_0_1;
                end
                else begin
                    next_state = IDLE;
                end
            end
            SEARCH_1_0_1: begin
                if (data == 1'b1) begin
                    next_state = FOUND;
                end
                else begin
                    next_state = IDLE;
                end
            end
            FOUND: begin
                start_shifting <= 1'b1;
                next_state = FOUND;
            end
        endcase
    end

endmodule
