module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] counter;
    reg start_detected;
    reg [3:0] remaining_time;
    reg searching;
    reg [3:0] state;

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset to initial state
            delay <= 0;
            counter <= 0;
            start_detected <= 0;
            remaining_time <= 0;
            searching <= 1;
            state <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            if (searching) begin
                // Detect start pattern
                if (data[3:0] == 4'b1101) begin
                    delay <= data[7:4];
                    start_detected <= 1;
                    searching <= 0;
                    state <= 0;
                end
            end else begin
                case (state)
                    4'b0000: begin
                        // Counting state
                        counting <= 1;
                        done <= 0;
                        if (counter == delay) begin
                            remaining_time <= delay - 1;
                            state <= 4'b0001;
                            counter <= 0;
                        end else begin
                            remaining_time <= delay;
                            counter <= counter + 1;
                        end
                    end
                    4'b0001: begin
                        // Counting state
                        counting <= 1;
                        done <= 0;
                        if (counter == 4'b0000) begin
                            remaining_time <= delay - 1;
                            state <= 4'b0000;
                            counter <= 0;
                        end else begin
                            remaining_time <= delay - 1;
                            counter <= counter + 1;
                        end
                    end
                endcase
            end
        end
    end

    // Combinational logic
    always @(*) begin
        if (start_detected && counting) begin
            count <= remaining_time;
        end else begin
            count <= 4'bxxxx;
        end
    end

    // Done state detection
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
        end else begin
            if (state == 4'b0000 && counter == 4'b0000 && ack) begin
                done <= 1;
            end
        end
    end

endmodule
