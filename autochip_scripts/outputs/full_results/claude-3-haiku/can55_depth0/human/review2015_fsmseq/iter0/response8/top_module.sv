module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// State definitions
parameter IDLE = 2'b00;
parameter SEARCH_1 = 2'b01;
parameter SEARCH_2 = 2'b10;
parameter SEARCH_3 = 2'b11;

// Internal state register
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    state <= SEARCH_1;
                else
                    state <= IDLE;
                start_shifting <= 0;
            end
            SEARCH_1: begin
                if (data == 1'b1)
                    state <= SEARCH_2;
                else
                    state <= IDLE;
                start_shifting <= 0;
            end
            SEARCH_2: begin
                if (data == 1'b0)
                    state <= SEARCH_3;
                else
                    state <= IDLE;
                start_shifting <= 0;
            end
            SEARCH_3: begin
                if (data == 1'b1) begin
                    state <= IDLE;
                    start_shifting <= 1;
                end
                else
                    state <= IDLE;
                start_shifting <= 0;
            end
            default: begin
                state <= IDLE;
                start_shifting <= 0;
            end
        endcase
    end
end

endmodule
