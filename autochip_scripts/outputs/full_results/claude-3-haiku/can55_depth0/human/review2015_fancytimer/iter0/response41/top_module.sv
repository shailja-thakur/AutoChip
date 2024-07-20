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

localparam IDLE = 2'd0;
localparam DETECT_START = 2'd1;
localparam CAPTURE_DELAY = 2'd2;
localparam COUNTING = 2'd3;

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
                if (data == 1'b1) begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) begin
                        state <= DETECT_START;
                    end
                end else begin
                    shift_reg <= 0;
                end
            end
            DETECT_START: begin
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1111) begin
                    state <= CAPTURE_DELAY;
                end
            end
            CAPTURE_DELAY: begin
                shift_reg <= {shift_reg[2:0], data};
                delay <= shift_reg;
                state <= COUNTING;
                counting <= 1;
            end
            COUNTING: begin
                if (counter == (delay + 1) * 250) begin
                    counting <= 0;
                    done <= 1;
                    state <= IDLE;
                end else begin
                    counter <= counter + 1;
                end
            end
        endcase

        if (done && ack) begin
            done <= 0;
        end
    end
end

assign count = (state == COUNTING) ? delay - (counter / 250) : 4'bxxxx;

endmodule
