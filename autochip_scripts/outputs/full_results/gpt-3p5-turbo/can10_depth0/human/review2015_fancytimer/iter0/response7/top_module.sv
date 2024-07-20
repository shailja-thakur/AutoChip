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

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            delay <= 4'b0000;
            state <= 3'b000;
            counting <= 0;
            done <= 0;
            counter <= 4'b0000;
        end else begin
            case (state)
                3'b000: begin
                    if (data == 1'b1) begin
                        state <= 3'b001;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b001: begin
                    if (data == 1'b1) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b010: begin
                    if (data == 1'b0) begin
                        state <= 3'b011;
                        delay <= {data, delay[3:1]};
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b011: begin
                    if (counter == (delay + 1)*1000 - 1) begin
                        counting <= 1;
                    end else if (counter == (delay + 1)*1000) begin
                        counting <= 0;
                        done <= 1;
                    end

                    counter <= counter + 1;
                end
            endcase
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'bxxxx;
        end else begin
            if (counting) begin
                count <= delay;
            end else begin
                count <= 4'bxxxx;
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
        end else begin
            if (done && ack) begin
                done <= 0;
            end
        end
    end
endmodule
