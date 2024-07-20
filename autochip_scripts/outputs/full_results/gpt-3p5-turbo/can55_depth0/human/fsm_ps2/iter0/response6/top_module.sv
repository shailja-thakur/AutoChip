module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Declare states
typedef enum logic [1:0] {
    STATE_IDLE,
    STATE_BYTE1,
    STATE_BYTE2,
    STATE_BYTE3,
    STATE_DONE
} state_t;

// Declare signals
reg [1:0] state;
reg done;

// Sequential logic
always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        done <= 0;
    end else begin
        case (state)
            STATE_IDLE: begin
                if (in[3] == 1) begin
                    state <= STATE_BYTE1;
                end
            end
            STATE_BYTE1: begin
                state <= STATE_BYTE2;
            end
            STATE_BYTE2: begin
                state <= STATE_BYTE3;
            end
            STATE_BYTE3: begin
                done <= 1; // Signal completion of message
                state <= STATE_DONE;
            end
            STATE_DONE: begin
                state <= STATE_IDLE;
                done <= 0;
            end
        endcase
    end
end

endmodule
