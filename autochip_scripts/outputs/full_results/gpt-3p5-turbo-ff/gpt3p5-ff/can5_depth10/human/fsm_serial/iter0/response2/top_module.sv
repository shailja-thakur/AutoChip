module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] data;
reg stop_bit_expected;

parameter START_BIT = 0;
parameter DATA_BIT = 1;
parameter STOP_BIT = 2;

always @(posedge clk) begin
    if (reset) begin
        state <= START_BIT;
        data <= 0;
        stop_bit_expected <= 0;
    end else begin
        case (state)
            START_BIT:
                if (in == 0) begin
                    state <= DATA_BIT;
                    data <= 0;
                    stop_bit_expected <= 0;
                end
            DATA_BIT:
                if (in == 1) begin
                    state <= DATA_BIT;
                    data <= {data[6:0], in};
                end else begin
                    state <= STOP_BIT;
                    stop_bit_expected <= 1;
                end
            STOP_BIT:
                if (in == stop_bit_expected) begin
                    state <= START_BIT;
                end
        endcase
    end
end

assign done = (state == STOP_BIT);

endmodule
