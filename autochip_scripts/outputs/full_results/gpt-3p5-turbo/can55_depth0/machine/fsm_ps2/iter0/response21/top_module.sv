module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Declare the states
typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
} state_type;

// Declare signals
reg [1:0] state;
reg done;

// State machine process
always @(posedge clk) begin
    if (reset) begin
        state <= BYTE1;
        done <= 0;
    end else begin
        case (state)
            BYTE1: begin
                if (in[2] == 1) begin
                    state <= BYTE2;
                end
            end
            BYTE2: begin
                state <= BYTE3;
            end
            BYTE3: begin
                state <= DONE;
            end
            DONE: begin
                if (in[2] == 0) begin
                    state <= BYTE1;
                end else begin
                    state <= BYTE2;
                end
            end
        endcase
    end
end

// Output assignment
always @(*) begin
    done = (state == DONE);
end

endmodule
