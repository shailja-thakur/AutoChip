module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] shift_reg;
    reg [2:0] state;

    assign count = counting ? shift_reg : 4'bxxxx;

    always @(posedge clk) begin
        if (reset)
            state <= 3'b000;
        else begin
            case(state)
                3'b000:
                    if (data == 4'b1101) begin
                        shift_reg <= data[3:0];
                        counting <= 1;
                        state <= 3'b001;
                    end
                    else begin
                        shift_reg <= shift_reg;
                        counting <= 0;
                        state <= 3'b000;
                    end
                3'b001:
                    shift_reg <= data[3:0];
                    counting <= 1;
                    state <= 3'b010;
                3'b010:
                    if (counting) begin
                        counting <= 1;
                        state <= 3'b010;
                    end
                    else begin
                        counting <= 0;
                        state <= 3'b011;
                    end
                3'b011:
                    done <= 1;
                    if (ack)
                        state <= 3'b000;
                    else
                        state <= 3'b011;
            endcase
        end
    end

endmodule
