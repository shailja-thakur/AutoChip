module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [1:0] state;
reg [3:0] delay;
reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        counting <= 0;
        done <= 0;
        state <= 2'b00;
        counter <= 0;
        delay <= 0;
    end else begin
        case (state)
            2'b00: begin
                if (data == 1 && counter == 0) begin
                    state <= 2'b01;
                    counter <= 3'b111;
                    delay[0] <= data;
                end
            end
            2'b01: begin
                if (counter > 0) begin
                    counter <= counter - 1;
                    delay <= {data, delay[3:1]};
                end else begin
                    counting <= 1;
                    state <= 2'b10;
                    counter <= (delay + 1) * 1000 - 1;
                end
            end
            2'b10: begin
                if (counter > 0) begin
                    counter <= counter - 1;
                    count <= delay;
                    if (counter % 1000 == 0) begin
                        delay <= delay - 1;
                    end
                end else begin
                    counting <= 0;
                    done <= 1;
                    state <= 2'b00;
                end
            end
            default: state <= 2'b00;
        endcase
    end
end

always @(negedge clk) begin
    if (reset) begin
        count <= 0;
    end
end

endmodule
