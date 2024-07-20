module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [1:0] state;

    wire [2:0] data_shift;
    reg [2:0] data_shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            count <= 4'b0;
            counting <= 0;
            done <= 0;
            delay <= 4'b0;
            data_shift_reg <= 3'b0;
        end else begin
            case(state)
                0: begin
                    if (data_shift[2:0] == 3'b110) begin
                        state <= 1;
                    end
                    data_shift_reg <= {data_shift_reg[1:0], data};
                end
                1: begin
                    data_shift_reg <= {data_shift_reg[1:0], data};
                    delay <= data_shift_reg[2:0];
                    state <= 2;
                end
                2: begin
                    counting <= 1;
                    if (count == delay) begin
                        if (counting) begin
                            done <= 1;
                            counting <= 0;
                        end else begin
                            done <= 0;
                            counting <= 1;
                        end
                        count <= delay;
                    end else begin
                        count <= count + 1;
                    end
                    if (counting && ack) begin
                        state <= 0;
                        data_shift_reg <= 3'b0;
                    end
                end
                default: state <= 0;
            endcase
        end
    end

endmodule
