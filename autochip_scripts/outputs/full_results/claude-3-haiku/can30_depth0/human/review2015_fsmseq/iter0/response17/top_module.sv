module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states of the finite state machine
localparam [1:0] WAIT_FOR_1 = 2'b00,
                 WAIT_FOR_0 = 2'b01,
                 WAIT_FOR_1_AGAIN = 2'b10,
                 FOUND_SEQUENCE = 2'b11;

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
                    state <= WAIT_FOR_0;
                end
                else begin
                    state <= WAIT_FOR_1;
                end
                start_shifting <= 1'b0;
            end
            WAIT_FOR_0: begin
                if (data == 1'b0) begin
                    state <= WAIT_FOR_1_AGAIN;
                end
                else begin
                    state <= WAIT_FOR_1;
                end
                start_shifting <= 1'b0;
            end
            WAIT_FOR_1_AGAIN: begin
                if (data == 1'b1) begin
                    state <= FOUND_SEQUENCE;
                end
                else begin
                    state <= WAIT_FOR_1;
                end
                start_shifting <= 1'b0;
            end
            FOUND_SEQUENCE: begin
                start_shifting <= 1'b1;
                state <= FOUND_SEQUENCE;
            end
            default: begin
                state <= WAIT_FOR_1;
                start_shifting <= 1'b0;
            end
        endcase
    end
end

endmodule
