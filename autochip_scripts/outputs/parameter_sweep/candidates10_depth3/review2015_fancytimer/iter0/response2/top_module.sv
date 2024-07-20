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
    reg [10:0] timer;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            counting <= 0;
            done <= 0;
            timer <= 0;
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
                    if (timer < delay) begin
                        timer <= timer + 1;
                        counting <= 1;
                    end else begin
                        counting <= 0;
                        done <= 1;
                    end
                end
                default: begin
                    state <= 3'b000;
                end
            endcase
        end
    end
    
    assign count = delay - (timer / 1000);
    always @(posedge clk) begin
        if (ack == 1'b1) begin
            done <= 0;
        end
    end

endmodule
