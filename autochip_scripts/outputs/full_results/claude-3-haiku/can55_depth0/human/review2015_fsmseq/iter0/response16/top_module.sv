module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter IDLE = 3'b000;
    parameter SEARCH_0 = 3'b001;
    parameter SEARCH_1 = 3'b010;
    parameter SEARCH_2 = 3'b011;
    parameter SEARCH_3 = 3'b100;

    reg [2:0] state, next_state;

    always @(posedge clk or posedge reset) begin
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
                if (data == 1'b0)
                    next_state = SEARCH_0;
                else
                    next_state = IDLE;
                start_shifting = 0;
            end
            SEARCH_0: begin
                if (data == 1'b1)
                    next_state = SEARCH_1;
                else
                    next_state = IDLE;
                start_shifting = 0;
            end
            SEARCH_1: begin
                if (data == 1'b0)
                    next_state = SEARCH_2;
                else
                    next_state = IDLE;
                start_shifting = 0;
            end
            SEARCH_2: begin
                if (data == 1'b1)
                    next_state = SEARCH_3;
                else
                    next_state = IDLE;
                start_shifting = 0;
            end
            SEARCH_3: begin
                next_state = SEARCH_3;
                start_shifting = 1;
            end
            default: begin
                next_state = IDLE;
                start_shifting = 0;
            end
        endcase
    end

endmodule
