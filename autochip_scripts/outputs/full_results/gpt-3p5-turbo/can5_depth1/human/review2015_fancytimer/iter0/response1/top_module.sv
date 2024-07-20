module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] count_reg;
    reg [3:0] remaining_time;
    reg [3:0] shift_reg;

    // State definitions
    localparam IDLE = 2'b00;
    localparam SEARCHING = 2'b01;
    localparam COUNTING = 2'b10;

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            count_reg <= 0;
            remaining_time <= 0;
            shift_reg <= 0;
        end else begin
            case (state)
                IDLE:
                    if (data == 1'b1 && $past(data) == 1'b0) begin
                        if (shift_reg == 4'b1101) begin
                            state <= COUNTING;
                            delay <= shift_reg;
                            counting <= 1;
                        end else begin
                            state <= SEARCHING;
                            shift_reg <= shift_reg << 1;
                            shift_reg[0] <= data;
                        end
                    end else begin
                        state <= SEARCHING;
                        shift_reg <= shift_reg << 1;
                        shift_reg[0] <= data;
                    end
                SEARCHING:
                    if (data == 1'b1 && $past(data) == 1'b0) begin
                        if (shift_reg == 4'b1101) begin
                            state <= COUNTING;
                            delay <= shift_reg;
                            counting <= 1;
                        end else begin
                            shift_reg <= shift_reg << 1;
                            shift_reg[0] <= data;
                        end
                    end else begin
                        shift_reg <= shift_reg << 1;
                        shift_reg[0] <= data;
                    end
                COUNTING:
                    if (count_reg == delay) begin
                        if (remaining_time == 0) begin
                            counting <= 0;
                            done <= 1;
                        end else begin
                            count_reg <= 0;
                            remaining_time <= remaining_time - 1;
                            counting <= 1;
                        end
                    end else begin
                        count_reg <= count_reg + 1;
                    end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end else if (counting) begin
            count <= count_reg;
        end else begin
            count <= 0; // Don't care value
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            remaining_time <= 0;
        end else if (counting) begin
            remaining_time <= delay - count_reg;
        end else begin
            remaining_time <= 0;
        end
    end

endmodule
