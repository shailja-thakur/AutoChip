module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            delay <= 0;
            state <= 0;
        end else begin
            case (state)
                0: begin
                    if (data == 1'b1) begin
                        // detecting the start pattern
                        state <= 1;
                    end else begin
                        state <= 0;
                    end
                end
                1: begin
                    if (data == 1'b1) begin
                        // shifting in the next 4 bits
                        delay <= {delay[2:0], data};
                        state <= 2;
                    end else begin
                        state <= 0;
                    end
                end
                2: begin
                    // waiting for the counters to finish counting
                    if (counting) begin
                        state <= 2;
                    end else begin
                        state <= 3;
                    end
                end
                3: begin
                    if (ack) begin
                        // notifying the user and waiting for the user to acknowledge the timer
                        done <= 1;
                        state <= 4;
                    end else begin
                        state <= 3;
                    end
                end
                4: begin
                    if (ack) begin
                        // resetting and searching for the start sequence
                        counting <= 0;
                        done <= 0;
                        delay <= 0;
                        state <= 0;
                    end else begin
                        state <= 4;
                    end
                end
                default: state <= 0;
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == 2) begin
            // start counting
            counting <= 1;
        else begin
            counting <= 0;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
        end else begin
            if (counting) begin
                // counting for exactly (delay[3:0] + 1) * 1000 clock cycles
                count <= delay + 1;
            end else begin
                count <= 4'b0000; // don't-care value when not counting
            end
        end
    end

endmodule
