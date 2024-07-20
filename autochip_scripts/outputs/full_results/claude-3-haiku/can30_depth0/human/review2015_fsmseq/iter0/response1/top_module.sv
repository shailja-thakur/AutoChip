module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states
localparam [1:0] 
    WAIT_FOR_1 = 2'b00,
    FOUND_1 = 2'b01,
    FOUND_10 = 2'b10,
    FOUND_101 = 2'b11;

// Declare the state register
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_1;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            WAIT_FOR_1: begin
                if (data == 1'b1) begin
                    state <= FOUND_1;
                end
                else begin
                    state <= WAIT_FOR_1;
                end
            end
            FOUND_1: begin
                if (data == 1'b0) begin
                    state <= FOUND_10;
                end
                else begin
                    state <= WAIT_FOR_1;
                end
            end
            FOUND_10: begin
                if (data == 1'b1) begin
                    state <= FOUND_101;
                end
                else begin
                    state <= WAIT_FOR_1;
                end
            end
            FOUND_101: begin
                if (data == 1'b0) begin
                    state <= WAIT_FOR_1;
                    start_shifting <= 1'b1;
                end
                else begin
                    state <= WAIT_FOR_1;
                end
            end
            default: begin
                state <= WAIT_FOR_1;
            end
        endcase
    end
end

endmodule
