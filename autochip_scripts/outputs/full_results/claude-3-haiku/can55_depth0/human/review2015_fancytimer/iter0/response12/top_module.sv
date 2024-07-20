module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

// Define state parameters
parameter IDLE = 2'b00, DETECT = 2'b01, COUNT = 2'b10, WAIT_ACK = 2'b11;
reg [1:0] state, next_state;

// Delay register
reg [3:0] delay;
reg [9:0] counter; // Counter for 1000 clock cycles

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;

        case (state)
            IDLE: begin
                counting <= 0;
                done <= 0;
                if (data == 1'b1) begin
                    next_state <= DETECT;
                end
                else begin
                    next_state <= IDLE;
                end
            end

            DETECT: begin
                // Detect the pattern 1101
                if ({data, data, data, data} == 4'b1101) begin
                    // Shift in the next 4 bits to determine the delay
                    delay <= {data, data, data, data};
                    next_state <= COUNT;
                end
                else if (data == 1'b0) begin
                    next_state <= IDLE;
                end
                else begin
                    next_state <= DETECT;
                end
            end

            COUNT: begin
                counting <= 1;
                if (counter == (delay + 1) * 10'd1000 - 1) begin
                    counting <= 0;
                    done <= 1;
                    next_state <= WAIT_ACK;
                end
                else begin
                    counter <= counter + 1;
                    next_state <= COUNT;
                end
            end

            WAIT_ACK: begin
                if (ack) begin
                    done <= 0;
                    next_state <= IDLE;
                end
                else begin
                    next_state <= WAIT_ACK;
                end
            end

            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay - (counter / 10'd1000) : 4'bxxxx;

endmodule
