module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [2:0] state;
    reg start_bit_received;
    reg [7:0] data;
    reg stop_bit_received;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            start_bit_received <= 0;
            data <= 0;
            stop_bit_received <= 0;
        end else begin
            case (state)
                0: begin // IDLE state
                    if (in == 1) begin
                        state <= 1;
                        start_bit_received <= 1;
                        data <= 0;
                        stop_bit_received <= 0;
                    end
                end
                1: begin // RECEIVE state
                    state <= 2;
                    start_bit_received <= 1;
                    data <= in;
                    stop_bit_received <= 0;
                end
                2: begin // RECEIVE DATA states
                    state <= (state == 9) ? 3 : state+1;
                    start_bit_received <= 1;
                    data <= {data[6:0], in};
                    stop_bit_received <= 0;
                end
                3: begin // RECEIVE STOP BIT state
                    if (in == 1) begin
                        state <= 0;
                        start_bit_received <= 0;
                        data <= 0;
                        stop_bit_received <= 1;
                    end else begin
                        state <= 1;
                        start_bit_received <= 1;
                        data <= 0;
                        stop_bit_received <= 0;
                    end
                end
                default: state <= 0;
            endcase
        end
    end

    assign done = stop_bit_received;

endmodule
