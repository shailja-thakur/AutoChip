module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

// Internal registers
reg [3:0] delay;
reg [3:0] counter;
reg [3:0] shift_reg;
reg [1:0] state;

// States
localparam WAIT_START = 2'd0;
localparam SHIFT_DELAY = 2'd1;
localparam COUNT_DELAY = 2'd2;
localparam WAIT_ACK = 2'd3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                // Shift in new data bit
                shift_reg <= {shift_reg[2:0], data};

                // Check for start pattern (1101)
                if (shift_reg == 4'b1101) begin
                    state <= SHIFT_DELAY;
                end
            end

            SHIFT_DELAY: begin
                // Shift in delay value
                delay <= {data, delay[3:1]};

                // Shift in all 4 bits of delay
                if (counter == 3) begin
                    state <= COUNT_DELAY;
                    counting <= 1;
                    counter <= 0;
                end else begin
                    counter <= counter + 1;
                end
            end

            COUNT_DELAY: begin
                // Decrement counter
                if (counter == (delay + 1)) begin
                    counter <= 0;
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end else begin
                    counter <= counter + 1;
                end
            end

            WAIT_ACK: begin
                // Wait for ack
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end

            default:
                state <= WAIT_START;
        endcase
    end
end

// Output current count value
assign count = (state == COUNT_DELAY) ? delay - counter : 4'bxxxx;

endmodule
