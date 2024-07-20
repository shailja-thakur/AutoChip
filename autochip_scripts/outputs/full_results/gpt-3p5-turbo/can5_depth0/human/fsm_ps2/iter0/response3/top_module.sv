module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// State definition
typedef enum logic [1:0] {
    WAIT_FOR_FIRST_BYTE,
    WAIT_FOR_SECOND_BYTE,
    WAIT_FOR_THIRD_BYTE
} state_t;

// Register declarations
reg [1:0] state;
reg [7:0] prev_byte;
reg done;

// State register
always_ff @(posedge clk, posedge reset) begin
    if (reset)
        state <= WAIT_FOR_FIRST_BYTE;
    else begin
        case (state)
            WAIT_FOR_FIRST_BYTE:
                if (in[3])
                    state <= WAIT_FOR_SECOND_BYTE;
            WAIT_FOR_SECOND_BYTE:
                state <= WAIT_FOR_THIRD_BYTE;
            WAIT_FOR_THIRD_BYTE:
                if (in[3]) begin
                    state <= WAIT_FOR_FIRST_BYTE;
                    done <= 1;
                end
                else
                    state <= WAIT_FOR_FIRST_BYTE;
        endcase
    end
end

// Output
assign done = 0;

endmodule
