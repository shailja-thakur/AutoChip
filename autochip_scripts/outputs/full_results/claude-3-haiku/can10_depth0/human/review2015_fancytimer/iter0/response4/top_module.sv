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
reg [1:0] state;

localparam IDLE = 2'b00;
localparam START = 2'b01;
localparam COUNT = 2'b10;
localparam DONE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        shift_reg <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            IDLE: begin
                // Look for the start sequence 1101
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    state <= START;
                end
            end
            START: begin
                // Shift in the delay value
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b1111) begin
                    delay <= shift_reg[3:0];
                    state <= COUNT;
                    counting <= 1;
                    counter <= 0;
                end
            end
            COUNT: begin
                // Count down the delay
                counter <= counter + 1;
                if (counter == delay) begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end
            end
            DONE: begin
                // Wait for acknowledgment
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay - counter : 4'bxxxx;

endmodule
