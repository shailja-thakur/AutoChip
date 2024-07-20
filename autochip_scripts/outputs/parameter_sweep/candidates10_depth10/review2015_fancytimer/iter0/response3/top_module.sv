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
    reg searching;
    reg [11:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            searching <= 1;
            counting <= 0;
            done <= 0;
            counter <= 0;
        end else begin
            case (state)
                0: begin // Initial state, searching for 1101 pattern
                    if (data == 4'b1101) begin
                        state <= 1;
                        delay <= 0;
                    end
                end
                1: begin // Read delay[3:0]
                    delay <= data;
                    state <= 2;
                end
                2: begin // Counting state
                    if (counter < (delay + 1) * 1000 - 1) begin
                        counter <= counter + 1;
                        counting <= 1;
                        if ((counter % 1000) == 0) begin // Update count[3:0]
                            count <= delay;
                            if (delay > 0) begin
                                delay <= delay - 1;
                            end
                        end
                    end else begin
                        counter <= 0;
                        counting <= 0;
                        state <= 3;
                    end
                end
                3: begin // Done state
                    done <= 1;
                    if (ack) begin
                        done <= 0;
                        state <= 0;
                        searching <= 1;
                    end
                end
            endcase
        end
    end

endmodule
