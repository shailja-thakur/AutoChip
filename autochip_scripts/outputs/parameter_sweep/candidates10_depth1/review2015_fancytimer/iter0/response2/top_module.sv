module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [2:0] state;
    reg [3:0] counter;
    wire start_sequence;

    assign start_sequence = (data === 4'b1101) ? 1'b1 : 1'b0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 1'b0;
            done <= 1'b0;
            state <= 3'b000;
        end else begin
            case (state)
                3'b000:
                    if (start_sequence) begin
                        delay <= data[3:0];
                        state <= 3'b001;
                    end
                3'b001:
                    begin
                        counting <= 1'b1;
                        state <= 3'b010;
                    end
                3'b010:
                    if (counter == (delay + 1)*1000 - 1) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        state <= 3'b011;
                    end else begin
                        counter <= counter + 1;
                    end
                3'b011:
                    if (ack) begin
                        state <= 3'b000;
                    end
            endcase
        end
    end

    assign count = counting ? delay : 4'bxxxx;

endmodule
