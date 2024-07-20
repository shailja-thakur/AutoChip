module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam WAIT_START  = 3'b000;
localparam WAIT_DELAY  = 3'b001;
localparam COUNTING    = 3'b010;
localparam WAIT_ACK    = 3'b011;

reg [2:0] state;
reg [3:0] shift_reg;
reg [15:0] timer;
reg [3:0] delay;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        timer <= 0;
        delay <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                // Look for start sequence 1101
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    state <= WAIT_DELAY;
                end
            end
            WAIT_DELAY: begin
                // Shift in delay[3:0]
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b1111) begin
                    delay <= shift_reg[3:0];
                    state <= COUNTING;
                    counting <= 1;
                    timer <= 0;
                end
            end
            COUNTING: begin
                // Count down timer and output remaining time
                timer <= timer + 16'd1;
                if (timer >= (delay + 1) * 16'd1000 - 1) begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end
                count <= delay - (timer / 16'd1000);
            end
            WAIT_ACK: begin
                // Wait for user acknowledgement
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
            default: begin
                state <= WAIT_START;
            end
        endcase
    end
end

endmodule
