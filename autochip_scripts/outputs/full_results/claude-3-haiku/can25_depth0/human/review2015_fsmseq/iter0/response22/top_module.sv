module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [1:0] state;
parameter SEARCH = 2'b00, FOUND = 2'b01, HOLD = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= SEARCH;
        start_shifting <= 0;
    end
    else begin
        case (state)
            SEARCH: begin
                if (data == 1'b1) begin
                    state <= FOUND;
                end
                else begin
                    state <= SEARCH;
                end
                start_shifting <= 0;
            end
            FOUND: begin
                if (data == 1'b0) begin
                    state <= SEARCH;
                end
                else begin
                    state <= HOLD;
                    start_shifting <= 1;
                end
            end
            HOLD: begin
                start_shifting <= 1;
                state <= HOLD;
            end
            default: begin
                state <= SEARCH;
                start_shifting <= 0;
            end
        endcase
    end
end

endmodule
