module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] state;
    reg [3:0] delay;
    reg [9:0] counter;  // To count up to 1000 * (delay + 1)
    reg [3:0] sequence; // To detect the pattern 1101
    reg [3:0] delay_bits; // To receive the delay[3:0]

    localparam IDLE       = 4'd0,
               DETECT1101 = 4'd1,
               READ_DELAY = 4'd2,
               COUNTDOWN  = 4'd3,
               WAIT_ACK   = 4'd4;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            sequence <= 4'd0;
            delay <= 4'd0;
            counter <= 10'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                    sequence <= {sequence[2:0], data};
                    if (sequence == 4'b1101) begin
                        state <= DETECT1101;
                    end
                end
                
                DETECT1101: begin
                    delay_bits <= {delay_bits[2:0], data};
                    if (delay_bits == 4'bxxx0) begin
                        delay <= {delay_bits, data};
                        state <= READ_DELAY;
                    end
                end
                
                READ_DELAY: begin
                    counting <= 1'b1;
                    count <= delay;
                    counter <= 10'd1000;
                    state <= COUNTDOWN;
                end
                
                COUNTDOWN: begin
                    if (counter == 10'd0) begin
                        if (count == 0) begin
                            counting <= 1'b0;
                            done <= 1'b1;
                            state <= WAIT_ACK;
                        end else begin
                            count <= count - 4'd1;
                            counter <= 10'd1000;
                        end
                    end else begin
                        counter <= counter - 10'd1;
                    end
                end
                
                WAIT_ACK: begin
                    if (ack) begin
                        state <= IDLE;
                    end
                end
                
            endcase
        end
    end
endmodule
