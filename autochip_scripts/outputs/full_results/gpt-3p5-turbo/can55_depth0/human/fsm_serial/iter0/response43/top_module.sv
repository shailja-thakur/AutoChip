module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [3:0] state;
reg start_detected;
reg [7:0] data;
reg stop_detected;

// FSM states
parameter IDLE = 0;
parameter WAIT_START = 1;
parameter RECEIVE_DATA = 2;
parameter WAIT_STOP = 3;
parameter FRAME_RECEIVED = 4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        start_detected <= 0;
        data <= 0;
        stop_detected <= 0;
    end else begin
        case (state)
            IDLE:
                if (in == 0) begin
                    state <= WAIT_START;
                    start_detected <= 1;
                    data <= 0;
                    stop_detected <= 0;
                end else begin
                    state <= IDLE;
                    start_detected <= 0;
                    data <= 0;
                    stop_detected <= 0;
                end
            WAIT_START:
                if (start_detected) begin
                    state <= RECEIVE_DATA;
                    start_detected <= 0;
                    data <= 0;
                    stop_detected <= 0;
                end else begin
                    state <= WAIT_START;
                    start_detected <= in;
                    data <= 0;
                    stop_detected <= 0;
                end
            RECEIVE_DATA:
                if (start_detected) begin
                    state <= RECEIVE_DATA;
                    start_detected <= in;
                    data <= {data[6:0], in};
                    stop_detected <= 0;
                end else if (data == 7'b1111111) begin
                    state <= WAIT_STOP;
                    start_detected <= 0;
                    data <= data;
                    stop_detected <= in;
                end else begin
                    state <= RECEIVE_DATA;
                    start_detected <= in;
                    data <= {data[6:0], in};
                    stop_detected <= 0;
                end
            WAIT_STOP:
                if (stop_detected) begin
                    state <= FRAME_RECEIVED;
                    start_detected <= 0;
                    data <= 0;
                    stop_detected <= 0;
                end else begin
                    state <= WAIT_STOP;
                    start_detected <= in;
                    data <= data;
                    stop_detected <= in;
                end
            FRAME_RECEIVED:
                state <= IDLE;
                start_detected <= 0;
                data <= 0;
                stop_detected <= 0;
        endcase
    end
end

assign done = (state == FRAME_RECEIVED);

endmodule
