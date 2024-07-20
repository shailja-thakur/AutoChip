module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] state;
    reg [1:0] shift_count;
    wire detect_pattern;

    assign detect_pattern = (data == 4'b1101);

    always @(posedge clk) begin
        if (reset) begin
            state <= 4'b1101;
            delay <= 4'b0;
            shift_count <= 2'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                4'b1101: begin
                    if (detect_pattern) begin
                        state <= 4'b0010;
                        shift_count <= 2'b0;
                    end else begin
                        state <= 4'b1101;
                    end
                end
                4'b0010: begin
                    state <= 4'b0100;
                    delay <= {data, data[3:1]};
                end
                4'b0100: begin
                    if (shift_count == delay) begin
                        state <= 4'b1000;
                        counting <= 1'b1;
                        count <= delay;
                    end else begin
                        state <= 4'b0100;
                        shift_count <= shift_count + 1;
                    end
                end
                4'b1000: begin
                    if (count == 4'b0000) begin
                        state <= 4'b0011;
                        counting <= 1'b0;
                        done <= 1'b1;
                    end else begin
                        state <= 4'b1000;
                        count <= count - 1;
                    end
                end
                4'b0011: begin
                    if (ack) begin
                        state <= 4'b1101;
                        done <= 1'b0;
                    end else begin
                        state <= 4'b0011;
                    end
                end
                default: state <= 4'b1101;
            endcase
        end
    end

endmodule
