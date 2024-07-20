module top_module (
	input clk,
	input in,
	input reset,
	output done
);

    reg [3:0] state;

    parameter S_IDLE = 0;
    parameter S_START_BIT = 1;
    parameter S_DATA_BITS = 2;
    parameter S_STOP_BIT = 3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            case (state)
                S_IDLE: begin
                    if (in == 1'b0) begin
                        state <= S_START_BIT;
                    end
                end
                S_START_BIT: begin
                    state <= S_DATA_BITS;
                end
                S_DATA_BITS: begin
                    state <= S_STOP_BIT;
                end
                S_STOP_BIT: begin
                    if (in == 1'b1) begin
                        state <= S_IDLE;
                    end
                end
            endcase
        end
    end

    assign done = (state == S_STOP_BIT);

endmodule
