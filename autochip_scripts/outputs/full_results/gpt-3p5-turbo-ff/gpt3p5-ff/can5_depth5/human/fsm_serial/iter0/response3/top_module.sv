module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg done;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
    end else begin
        case(state)
            IDLE: begin
                if (in == 0) begin
                    state <= START_BIT;
                end else begin
                    state <= IDLE;
                end
            end
            START_BIT: begin
                state <= DATA_BITS;
            end
            DATA_BITS: begin
                if (in == 1) begin
                    state <= STOP_BIT;
                end else begin
                    state <= DATA_BITS;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin
                    state <= IDLE;
                    done <= 1;
                end else begin
                    state <= DATA_BITS;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule
