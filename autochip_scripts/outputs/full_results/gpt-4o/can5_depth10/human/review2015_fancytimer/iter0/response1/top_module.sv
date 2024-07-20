module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack 
);

    parameter IDLE = 2'b00,
              DETECT = 2'b01,
              LOAD_DELAY = 2'b10,
              COUNT = 2'b11;
              
    reg [1:0] state, next_state;
    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [13:0] counter; // 14-bit counter to count upto 10000 cycles

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 4'b0000;
            delay <= 4'b0000;
            counter <= 14'b00000000000000;
            counting <= 0;
            done <= 0;
            count <= 4'bxxxx;
        end
        else begin
            state <= next_state;
            // State machine behavior
            case (state)
                IDLE: begin
                    shift_reg <= 4'b0000;
                    counting <= 0;
                    done <= 0;
                    if (data) shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) next_state <= DETECT;
                end
                DETECT: begin
                    shift_reg <= 4'b0000;
                    counting <= 0;
                    if (data) shift_reg <= {shift_reg[2:0], data};
                    if (&shift_reg[2:0]) begin // MSB of next 4 bits is received
                        delay <= {shift_reg[2:0], data};
                        next_state <= LOAD_DELAY;
                    end
                end
                LOAD_DELAY: begin
                    counter <= (delay + 4'b0001) * 1000;
                    counting <= 1;
                    next_state <= COUNT;
                end
                COUNT: begin
                    if(counter > 0) begin
                        counter <= counter - 1;
                        count <= counter / 1000;
                    end
                    else begin
                        counting <= 0;
                        done <= 1;
                        next_state <= IDLE;
                        if (ack) next_state <= IDLE;
                    end
                end
                default: next_state <= IDLE;
            endcase
        end
    end

endmodule
