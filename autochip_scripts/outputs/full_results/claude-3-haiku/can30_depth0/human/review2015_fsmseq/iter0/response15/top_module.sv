module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states for the finite-state machine
localparam [1:0] WAIT_FOR_1 = 2'b00,
                 WAIT_FOR_1_0 = 2'b01,
                 WAIT_FOR_1_1_0 = 2'b10,
                 FOUND_1101 = 2'b11;

// Define the state register
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_1;
        start_shifting <= 0;
    end
    else begin
        case (state)
            WAIT_FOR_1: begin
                if (data == 1'b1)
                    state <= WAIT_FOR_1_0;
                else
                    state <= WAIT_FOR_1;
            end
            WAIT_FOR_1_0: begin
                if (data == 1'b0)
                    state <= WAIT_FOR_1_1_0;
                else
                    state <= WAIT_FOR_1;
            end
            WAIT_FOR_1_1_0: begin
                if (data == 1'b1)
                    state <= FOUND_1101;
                else
                    state <= WAIT_FOR_1;
            end
            FOUND_1101: begin
                start_shifting <= 1;
                state <= FOUND_1101;
            end
            default: begin
                state <= WAIT_FOR_1;
                start_shifting <= 0;
            end
        endcase
    end
end

endmodule
