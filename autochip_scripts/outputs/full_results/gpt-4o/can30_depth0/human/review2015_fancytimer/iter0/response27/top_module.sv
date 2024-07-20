module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [3:0] state;
    reg [3:0] delay;
    reg [13:0] counter;
    reg [5:0] bit_shift;
    wire detect_1101;

    localparam S_SEARCH = 4'b0000,
               S_SHIFT  = 4'b0001,
               S_COUNT  = 4'b0010,
               S_DONE   = 4'b0011;
    
    assign detect_1101 = (bit_shift[3:0] == 4'b1101);
    assign count = counter[13:10];

    always @(posedge clk) begin
        if (reset) begin
            state <= S_SEARCH;
            bit_shift <= 6'b0;
            delay <= 4'b0;
            counter <= 14'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case(state)
                S_SEARCH: begin
                    bit_shift <= {bit_shift[2:0], data};
                    if (detect_1101) begin
                        state <= S_SHIFT;
                        delay <= 4'b0;
                        counter <= 14'b0;
                    end
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                S_SHIFT: begin
                    bit_shift <= {bit_shift[2:0], data};
                    delay <= {delay[2:0], data};
                    if (bit_shift[5:2] == 4'b1101) begin
                        state <= S_COUNT;
                        counter <= (4'd1 + delay) * 1000;
                        counting <= 1'b1;
                    end
                end
                S_COUNT: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                    end else begin
                        state <= S_DONE;
                        counting <= 1'b0;
                        done <= 1'b1;
                    end
                end
                S_DONE: begin
                    if (ack) begin
                        state <= S_SEARCH;
                        bit_shift <= 6'b0;
                    end
                    counting <= 1'b0;
                end
                default: state <= S_SEARCH;
            endcase
        end
    end
endmodule
