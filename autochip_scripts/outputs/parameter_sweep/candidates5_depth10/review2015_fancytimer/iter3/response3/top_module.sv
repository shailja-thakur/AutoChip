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
    reg [19:0] counter;
    reg [3:0] state;
    reg start_detected;
    wire counting;

    // Constants
    parameter IDLE = 4'b0000;
    parameter START_DETECT = 4'b0001;
    parameter SHIFT_IN = 4'b0010;
    parameter COUNT = 4'b0011;
    parameter WAIT_ACK = 4'b0100;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_detected <= 0;
            counter <= 0;
            done <= 0;
            counting <= 0;
            count_reg <= 0;
        end else begin
            case (state)
                IDLE:
                    if (data == 1'b1 && start_detected == 1'b0) begin
                        start_detected <= 1'b1;
                        state <= START_DETECT;
                    end else begin
                        start_detected <= 1'b0;
                        state <= IDLE;
                    end
                START_DETECT:
                    if (data == 1'b1 && start_detected == 1'b1) begin
                        state <= SHIFT_IN;
                    end else begin
                        start_detected <= 1'b0;
                        state <= IDLE;
                    end
                SHIFT_IN:
                    if (start_detected == 1'b1) begin
                        delay <= {delay[2:0], data};
                        state <= COUNT;
                        counter <= 0;
                    end else begin
                        state <= IDLE;
                    end
                COUNT:
                    if (count_reg == delay) begin
                        counting <= 0;
                        state <= WAIT_ACK;
                        counter <= counter + 1;
                    end else begin
                        counting <= 1;
                        count_reg <= count_reg + 1;
                        state <= COUNT;
                        counter <= counter + 1;
                    end
                WAIT_ACK:
                    if (ack == 1'b1) begin
                        done <= 1'b1;
                        state <= IDLE;
                        counter <= 0;
                    end else begin
                        done <= 0;
                        counter <= counter + 1;
                        state <= WAIT_ACK;
                    end
            endcase
        end
    end

    assign count = counting ? (delay - count_reg) : 0;

endmodule
