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

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'd0;
            counting <= 0;
            done <= 0;
            delay <= 0;
        end else begin
            case (state)
                3'b000: begin  // Wait for start sequence (1101)
                    if (data == 4'b1101) begin
                        state <= 3'b001;
                        counting <= 0;
                        done <= 0;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b001: begin  // Shift in delay value
                    delay <= data;
                    state <= 3'b010;
                end
                3'b010: begin  // Start counting
                    counting <= 1;
                    state <= 3'b011;
                end
                3'b011: begin  // Count for (delay[3:0] + 1) * 1000 cycles
                    if (counting == ((delay+1)*1000 - 1)) begin
                        done <= 1;
                    end else if (counting == ((delay+1)*2000 - 1)) begin
                        done <= 0;
                        state <= 3'b100;
                    end else begin
                        state <= 3'b011;
                    end
                    counting <= counting + 1;
                end
                3'b100: begin  // Wait for ack
                    if (ack) begin
                        state <= 3'b000;
                    end else begin
                        state <= 3'b100;
                    end
                end
            endcase
        end
    end

    assign count = counting ? delay : 4'bxxxx;

endmodule
