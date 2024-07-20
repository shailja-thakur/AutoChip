module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state;
    reg [2:0] counter;
    reg rx_data;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            rx_data <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (in == 0) begin
                        state <= START;
                        counter <= 0;
                        rx_data <= 0;
                    end
                end
                START: begin
                    state <= DATA;
                    counter <= 0;
                    rx_data <= in;
                end
                DATA: begin
                    if (counter == 7) begin
                        state <= STOP;
                        counter <= 0;
                        rx_data <= in;
                    end else begin
                        counter <= counter + 1;
                        rx_data <= {rx_data[6:0], in};
                    end
                end
                STOP: begin
                    state <= IDLE;
                    counter <= 0;
                    rx_data <= 0;
                    if (in == 1) begin
                        out_byte <= rx_data;
                        done <= 1;
                    end else begin
                        done <= 0;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end

endmodule
