module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states
localparam [1:0] 
    WAIT_FOR_ONE = 2'b00,
    WAIT_FOR_ONE_ONE = 2'b01,
    WAIT_FOR_ONE_ONE_ZERO = 2'b10,
    FOUND_SEQUENCE = 2'b11;

// State register
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_ONE;
        start_shifting <= 1'b0;
    end else begin
        case (state)
            WAIT_FOR_ONE: begin
                if (data == 1'b1) begin
                    state <= WAIT_FOR_ONE_ONE;
                end else begin
                    state <= WAIT_FOR_ONE;
                end
                start_shifting <= 1'b0;
            end
            WAIT_FOR_ONE_ONE: begin
                if (data == 1'b1) begin
                    state <= WAIT_FOR_ONE_ONE_ZERO;
                end else begin
                    state <= WAIT_FOR_ONE;
                end
                start_shifting <= 1'b0;
            end
            WAIT_FOR_ONE_ONE_ZERO: begin
                if (data == 1'b0) begin
                    state <= FOUND_SEQUENCE;
                    start_shifting <= 1'b1;
                end else begin
                    state <= WAIT_FOR_ONE;
                    start_shifting <= 1'b0;
                end
            end
            FOUND_SEQUENCE: begin
                start_shifting <= 1'b1;
            end
            default: begin
                state <= WAIT_FOR_ONE;
                start_shifting <= 1'b0;
            end
        endcase
    end
end

endmodule
