module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // Internal signals
    reg [1:0] state;
    reg [3:0] delay;
    reg [11:0] counter;
    reg [3:0] remaining_time;
    reg [3:0] count_reg; // Register to store the count output

    // Constants
    parameter IDLE = 2'b00;
    parameter DETECTING = 2'b01;
    parameter COUNTING = 2'b10;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            counter <= 0;
            remaining_time <= 0;
            count_reg <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= DETECTING;
                        counting <= 0;
                    end
                end

                DETECTING: begin
                    delay <= data;
                    state <= COUNTING;
                    counter <= (delay + 1) * 1000;
                    remaining_time <= delay;
                    count_reg <= delay;
                end

                COUNTING: begin
                    counting <= 1;
                    if (counter > 0) begin
                        counter <= counter - 1;
                    end else begin
                        if (ack) begin
                            state <= IDLE;
                            counting <= 0;
                            done <= 1;
                        end
                    end
                    if (counter % 1000 == 0) begin
                        count_reg <= count_reg - 1;
                    end
                end
            endcase
        end
    end

    // Output assignment
    assign count = count_reg;

endmodule
