module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

reg [2:0] state, next_state;

// State definition
parameter IDLE_STATE = 0;
parameter PATTERN_STATE = 1;
parameter FLAG_STATE = 2;
parameter ERROR_STATE = 3;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE_STATE;
    end else begin
        state <= next_state;
    end
end

always @(state or in) begin
    case(state)
        IDLE_STATE: begin
            if (in == 1) begin
                next_state <= PATTERN_STATE;
            end else begin
                next_state <= IDLE_STATE;
            end
        end
        PATTERN_STATE: begin
            if (in == 1) begin
                next_state <= ERROR_STATE;
            end else begin
                next_state <= FLAG_STATE;
            end
        end
        FLAG_STATE: begin
            if (in == 1) begin
                next_state <= ERROR_STATE;
            end else begin
                next_state <= IDLE_STATE;
            end
        end
        ERROR_STATE: begin
            next_state <= FLAG_STATE;
        end
    endcase
end

// Output generation
assign disc = (state == PATTERN_STATE);
assign flag = (state == FLAG_STATE);
assign err = (state == ERROR_STATE);

endmodule
