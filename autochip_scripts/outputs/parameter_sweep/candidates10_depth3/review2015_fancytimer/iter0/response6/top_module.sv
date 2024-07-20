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
    reg [1:0] state;
    reg [9:0] counter;

    // State defines
    localparam IDLE = 2'b00;
    localparam DETECT = 2'b01;
    localparam COUNT = 2'b10;

    // Continuous assignments
    assign count = count;
    assign counting = (state == COUNT);
    assign done = (state == IDLE && ack);

    // State machine
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            delay <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= DETECT;
                        delay <= data[3:0];
                    end else begin
                        state <= IDLE;
                    end
                end
                DETECT: begin
                    state <= COUNT;
                end
                COUNT: begin
                    if (counter == (delay + 1) * 1000 - 1) begin
                        state <= IDLE;
                    end else begin
                        state <= COUNT;
                    end
                end
            endcase
        end
    end

    // Counter
    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
        end else if (state == COUNT) begin
            if (counter == (delay + 1) * 1000 - 1) begin
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end
    
endmodule
