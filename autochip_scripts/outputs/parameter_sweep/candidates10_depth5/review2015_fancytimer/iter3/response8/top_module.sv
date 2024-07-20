module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [2:0] state;
    reg [3:0] delay;
    reg [23:0] counter;
    reg flag;
    reg [3:0] remaining_time;
    wire start_sequence;

    assign start_sequence = (data == 1'b1) ? ((flag == 1'b1) ? 1'b1 : 1'b0) : 1'b0;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            delay <= 4'b0000;
            counter <= 0;
            counting <= 0;
            done <= 0;
            flag <= 0;
            remaining_time <= 0;
        end else begin
            case (state)
                3'b000: begin
                    if (start_sequence) begin
                        state <= 3'b001;
                        counting <= 1;
                    end else if (data == 1'b1) begin
                        flag <= 1;
                    end
                end
                3'b001: begin
                    delay <= {data, delay[3:1]};
                    state <= 3'b010;
                    counter <= 0;
                    remaining_time <= delay;
                end
                3'b010: begin
                    if (counter == ((delay + 1) * 1000)) begin
                        counting <= 0;
                        done <= 1;
                        state <= 3'b011;
                    end else begin
                        counter <= counter + 1;
                        if (counter % 1000 == 0) begin
                            remaining_time <= remaining_time - 1;
                        end
                    end
                end
                3'b011: begin
                    if (ack == 1'b1) begin
                        done <= 0;
                        flag <= 0;
                        state <= 3'b000;
                    end
                end
            endcase
        end
    end

    assign count = counting ? remaining_time : 4'bxxxx;

endmodule
