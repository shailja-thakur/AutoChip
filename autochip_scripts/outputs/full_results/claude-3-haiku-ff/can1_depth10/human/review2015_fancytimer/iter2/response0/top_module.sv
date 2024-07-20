module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam IDLE = 3'b000;
localparam DETECT_PATTERN = 3'b001;
localparam STORE_DELAY = 3'b010;
localparam COUNTING = 3'b011;
localparam NOTIFY = 3'b100;

reg [2:0] state;
reg [3:0] shift_reg;
reg [12:0] counter;
reg [3:0] delay;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_reg <= 4'b0;
        counter <= 13'b0;
        delay <= 4'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (shift_reg[3:0] == 4'b1101) begin
                    state <= STORE_DELAY;
                    shift_reg <= 4'b0;
                    counter <= 13'b0;
                end else begin
                    shift_reg <= {shift_reg[2:0], data};
                end
            end
            STORE_DELAY: begin
                if (counter < 4) begin
                    shift_reg <= {shift_reg[2:0], data};
                    counter <= counter + 1;
                end else begin
                    delay <= shift_reg[3:0];
                    counter <= 13'b0;
                    state <= COUNTING;
                    counting <= 1'b1;
                end
            end
            COUNTING: begin
                counter <= counter + 1;
                if (counter == (delay + 1) * 1000 - 1) begin
                    counter <= 13'b0;
                    state <= NOTIFY;
                    counting <= 1'b0;
                end
            end
            NOTIFY: begin
                done <= 1'b1;
                if (ack) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

always @* begin
    case (state)
        COUNTING: count = delay - (counter / 1000);
        default: count = 4'bxxxx;
    endcase
end

endmodule
