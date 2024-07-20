module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // Internal signals
    reg [3:0] delay;
    reg [3:0] count_reg;
    reg start_detected;
    reg searching;
    reg [3:0] state;
	reg [31:0] counter; // Counter for clock cycles

    // Constants
    parameter IDLE = 4'b0000;
    parameter START_DETECT = 4'b0001;
    parameter SHIFT_IN = 4'b0010;
    parameter COUNT = 4'b0011;
    parameter WAIT_ACK = 4'b0100;

    always @(posedge clk) begin
        if (reset) begin
            searching <= 1'b1;
            count_reg <= 4'b0000;
            delay <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            state <= IDLE;
            start_detected <= 1'b0;
			counter <= 32'b0;
        end else begin
			counter <= counter + 1;
            case (state)
                IDLE:
                    if (data == 1'b1 && start_detected == 1'b0) begin
                        start_detected <= 1'b1;
                        state <= START_DETECT;
                    end
                START_DETECT:
                    if (data == 1'b0 && start_detected == 1'b1) begin
                        start_detected <= 1'b0;
                        state <= SHIFT_IN;
                    end else if (data == 1'b1 && start_detected == 1'b1) begin
                        state <= START_DETECT;
                    end else begin
                        state <= IDLE;
                    end
                SHIFT_IN:
                    if (start_detected == 1'b1) begin
                        delay <= {delay[2:0], data};
                        state <= COUNT;
                    end else begin
                        state <= IDLE;
                    end
                COUNT:
                    if (counter == (delay + 1) * 1000) begin
                        count_reg <= 0;
                        counting <= 1'b0;
                        state <= WAIT_ACK;
						counter <= 0;
                    end else begin
                        count_reg <= count_reg + 1'b1;
                        counting <= 1'b1;
                        state <= COUNT;
                    end
                WAIT_ACK:
                    if (ack == 1'b1) begin
                        done <= 1'b1;
                        state <= IDLE;
                    end else begin
                        state <= WAIT_ACK;
                    end
            endcase
        end
    end

    assign count = delay - count_reg;

endmodule
