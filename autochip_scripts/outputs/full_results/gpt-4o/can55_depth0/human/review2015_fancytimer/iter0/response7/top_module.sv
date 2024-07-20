module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] state;
    reg [3:0] delay;
    reg [11:0] counter;
    reg [6:0] bit_counter;
    reg [3:0] received_bits;

    localparam IDLE = 4'b0000;
    localparam DETECT_1 = 4'b0001;
    localparam DETECT_11 = 4'b0010;
    localparam DETECT_110 = 4'b0011;
    localparam DETECT_1101 = 4'b0100;
    localparam READ_DELAY = 4'b0101;
    localparam COUNTING = 4'b0110;
    localparam DONE = 4'b0111;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            delay <= 4'b0000;
            counter <= 12'b0;
            bit_counter <= 7'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    counting <= 1'b0;
                    if (data) state <= DETECT_1;
                end
                DETECT_1: begin
                    if (data) state <= DETECT_11;
                    else state <= IDLE;
                end
                DETECT_11: begin
                    if (data) state <= DETECT_110;
                    else state <= IDLE;
                end
                DETECT_110: begin
                    if (data) state <= DETECT_1101;
                    else state <= IDLE;
                end
                DETECT_1101: begin
                    state <= READ_DELAY;
                    bit_counter <= 7'b0;
                end
                READ_DELAY: begin
                    if (bit_counter < 4) begin
                        received_bits <= {received_bits[2:0], data};
                        bit_counter <= bit_counter + 1;
                    end else begin
                        delay <= received_bits;
                        counter <= (received_bits + 1) * 1000;
                        state <= COUNTING;
                        counting <= 1'b1;
                    end
                end
                COUNTING: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                    end else begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        state <= DONE;
                    end
                end
                DONE: begin
                    if (ack) state <= IDLE;
                end
                default: state <= IDLE;
            endcase
        end
    end
    
    assign count = counter[11:8];

endmodule
