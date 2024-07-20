module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay;
reg [3:0] counter;
reg [3:0] shift_reg;
reg [2:0] state;

localparam WAIT_START = 3'b000;
localparam SHIFT_DELAY = 3'b001;
localparam COUNT_DOWN = 3'b010;
localparam WAIT_ACK = 3'b011;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end
    else begin
        case (state)
            WAIT_START: begin
                // Wait for the start sequence 1101
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    state <= SHIFT_DELAY;
                end
            end
            SHIFT_DELAY: begin
                // Shift in the 4-bit delay value
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b1111) begin
                    delay <= shift_reg[3:0];
                    counter <= 0;
                    state <= COUNT_DOWN;
                    counting <= 1;
                end
            end
            COUNT_DOWN: begin
                // Count down the timer
                counter <= counter + 1;
                if (counter == delay) begin
                    counter <= 0;
                    delay <= delay - 1;
                end
                if (delay == 0) begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                // Wait for the user to acknowledge the timer
                if (ack) begin
                    done <= 0;
                    state <= WAIT_START;
                end
            end
        endcase
    end
end

assign count = delay;

endmodule
