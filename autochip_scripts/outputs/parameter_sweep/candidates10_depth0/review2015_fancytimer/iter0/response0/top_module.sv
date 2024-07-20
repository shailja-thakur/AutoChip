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

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                3'b000: begin
                    if (data == 1'b1) begin
                        state <= 3'b001;
                    end
                end

                3'b001: begin
                    if (data == 1'b1) begin
                        state <= 3'b010;
                        delay <= 4'b0000;
                    end else begin
                        state <= 3'b000;
                    end
                end

                3'b010: begin
                    if (data == 1'b1) begin
                        state <= 3'b011;
                        delay[3] <= data;
                    end else begin
                        state <= 3'b000;
                    end
                end

                3'b011: begin
                    state <= 3'b100;
                    delay[2] <= data;
                end

                3'b100: begin
                    state <= 3'b101;
                    delay[1] <= data;
                end

                3'b101: begin
                    state <= 3'b110;
                    delay[0] <= data;
                end

                3'b110: begin
                    counting <= 1;
                    state <= 3'b111;
                end

                3'b111: begin
                    if (counting && (count == (delay + 1))) begin
                        counting <= 0;
                        done <= 1;
                    end else if (!counting) begin
                        if (ack) begin
                            state <= 3'b000;
                            done <= 0;
                        end
                    end
                end
            endcase
        end
    end

    assign count = counting ? delay : 4'bzzzz; // don't-care when not counting

endmodule
