module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states
localparam [1:0] IDLE = 2'b00, SEARCH = 2'b01, FOUND = 2'b11;

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
                if (data == 1'b1) begin
                    state <= SEARCH;
                end
                else begin
                    state <= IDLE;
                end
                start_shifting <= 0;
            end
            SEARCH: begin
                if (data == 1'b0 && start_shifting == 0) begin
                    state <= SEARCH;
                end
                else if (data == 1'b1) begin
                    state <= SEARCH;
                end
                else if (data == 1'b0) begin
                    state <= IDLE;
                end
                else if (data == 1'b1) begin
                    state <= FOUND;
                end
                start_shifting <= 0;
            end
            FOUND: begin
                state <= FOUND;
                start_shifting <= 1;
            end
            default: begin
                state <= IDLE;
                start_shifting <= 0;
            end
        endcase
    end
end

endmodule
