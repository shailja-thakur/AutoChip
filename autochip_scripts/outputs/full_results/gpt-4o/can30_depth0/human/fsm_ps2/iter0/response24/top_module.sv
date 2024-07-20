module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

    reg [1:0] state, next_state;
    reg [1:0] byte_count;

    // State codes
    parameter WAIT_START = 2'b00;
    parameter BYTE1      = 2'b01;
    parameter BYTE2      = 2'b10;
    parameter BYTE3      = 2'b11;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_START;
            byte_count <= 2'b00;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state != WAIT_START) begin
                byte_count <= byte_count + 1;
            end
            else begin
                byte_count <= 2'b00;
            end
            done <= (byte_count == 2'b10) && (state == BYTE3);
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            WAIT_START: begin
                if (in[3]) begin
                    next_state = BYTE1;
                end
                else begin
                    next_state = WAIT_START;
                end
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = WAIT_START;
            default: next_state = WAIT_START;
        endcase
    end

endmodule
