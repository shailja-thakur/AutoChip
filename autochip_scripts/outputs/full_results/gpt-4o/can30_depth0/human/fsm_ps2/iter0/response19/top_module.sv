module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

    // State encoding
    reg [1:0] state, next_state;
    localparam IDLE = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;

    // State transitions
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        done = 1'b0; // Default value
        case (state)
            IDLE: begin
                if (in[3])
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                done = 1'b1;
                if (in[3])
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
