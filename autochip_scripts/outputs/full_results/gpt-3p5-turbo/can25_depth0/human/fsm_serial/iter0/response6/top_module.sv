module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [2:0] state;
reg start_bit_detected;
reg [7:0] data_counter;
reg stop_bit_detected;

parameter IDLE = 0;
parameter RECEIVE = 1;
parameter CHECK_STOP = 2;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_bit_detected <= 0;
        data_counter <= 0;
        stop_bit_detected <= 0;
    end else begin
        case(state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= RECEIVE;
                    start_bit_detected <= 1;
                    data_counter <= 0;
                    stop_bit_detected <= 0;
                end
            end
            RECEIVE: begin
                if (data_counter == 7) begin
                    state <= CHECK_STOP;
                end else begin
                    data_counter <= data_counter + 1;
                end
            end
            CHECK_STOP: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    if (start_bit_detected && stop_bit_detected) begin
                        done <= 1;
                    end
                    start_bit_detected <= 0;
                    data_counter <= 0;
                    stop_bit_detected <= 0;
                end else begin
                    stop_bit_detected <= 1;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule
