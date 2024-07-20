module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    parameter IDLE = 2'b00;
    parameter DETECT_PATTERN = 2'b01;
    parameter SHIFT_IN = 2'b10;
    parameter COUNT = 2'b11;

    reg [1:0] state;
    reg [3:0] delay;
    reg [3:0] remaining_time;
    reg [3:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0;
            delay <= 4'b0;
            counting <= 1'b0; // Initialize counting to 0
            done <= 1'b0; // Initialize done to 0
        end else begin
            case(state)
                IDLE: begin
                    count <= 4'bzzzz; // Set count to don't-care value
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (data == 4'b1101) begin // Check 4-bit pattern
                        state <= SHIFT_IN;
                    end
                end

                SHIFT_IN: begin
                    counter <= counter + 1;
                    if (counter == 4'b1111) begin
                        counter <= 4'b0;
                        delay <= data;
                        state <= COUNT;
                        counting <= 1'b1; // Start counting
                    end
                end

                COUNT: begin
                    if (counter == ((delay + 1) * 4'b1111)) begin
                        counting <= 1'b0; // Stop counting
                        done <= 1'b1; // Set done to 1
                        state <= IDLE;
                    end else begin
                        counter <= counter + 1;
                        remaining_time <= delay - (counter / 4'b1111);
                    end
                end
            endcase
        end
    end

    assign count = remaining_time; // Set count to remaining_time

    always @(posedge clk) begin
        if (reset) begin
            remaining_time <= 4'b0;
        end else if (state == IDLE) begin
            remaining_time <= delay;
        end
    end

endmodule
