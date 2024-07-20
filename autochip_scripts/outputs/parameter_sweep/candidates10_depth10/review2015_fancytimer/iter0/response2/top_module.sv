module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [3:0] delay;
reg [3:0] count;
reg [3:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counting <= 0;
        done <= 0;
        state <= 0;
        count <= 0;
        delay <= 0;
    end else begin
        case (state)
            0: begin
                if (data == 1'b1) begin
                    state <= 1;
                end
            end
            1: begin
                if (data == 1'b1) begin
                    state <= 2;
                end else begin
                    state <= 0;
                end
            end
            2: begin
                if (data == 1'b1) begin
                    state <= 3;
                end else begin
                    state <= 0;
                end
            end
            3: begin
                if (data == 1'b0) begin
                    state <= 0;
                end else begin
                    state <= 4;
                    delay <= data[3:0];
                end
            end
            4: begin
                counting <= 1;
                if (count == (delay + 1) * 1000) begin
                    counting <= 0;
                    done <= 1;
                    if (ack == 1) begin
                        state <= 0;
                        count <= 0;
                        done <= 0;
                    end
                end else begin
                    count <= count + 1;
                end
            end
            default: begin
                state <= 0;
            end
        endcase
    end
end

endmodule
