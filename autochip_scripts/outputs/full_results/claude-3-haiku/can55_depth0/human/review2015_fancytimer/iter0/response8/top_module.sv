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

localparam WAIT_START = 2'd0;
localparam SHIFT_DELAY = 2'd1;
localparam COUNTING = 2'd2;
localparam WAIT_ACK = 2'd3;

always @(posedge clk) begin
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
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= SHIFT_DELAY;
                    shift_reg <= 0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            SHIFT_DELAY: begin
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg[3:0] == 4'b0000) begin
                    delay <= 4'b0000;
                    state <= COUNTING;
                    counting <= 1;
                end
            end
            COUNTING: begin
                counter <= counter + 1;
                if (counter == delay + 1) begin
                    counter <= 0;
                    if (delay == 0) begin
                        state <= WAIT_ACK;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        delay <= delay - 1;
                    end
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = delay;

endmodule
