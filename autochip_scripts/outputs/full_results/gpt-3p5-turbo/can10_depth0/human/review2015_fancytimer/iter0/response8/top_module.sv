module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] remaining;
    reg found_sequence;
    reg [3:0] state;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= 4'b0000;
        end else begin
            case(state)
                4'b0000: begin
                    if(data == 4'b1101) begin
                        state <= 4'b0001;
                        delay <= data;
                        counting <= 1;
                    end
                end
                4'b0001: begin
                    state <= 4'b0010;
                end
                4'b0010: begin
                    state <= 4'b0011;
                end
                4'b0011: begin
                    state <= 4'b0100;
                end
                4'b0100: begin
                    state <= 4'b0101;
                end
                4'b0101: begin
                    if(remaining == 0) begin
                        state <= 4'b0110;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        state <= 4'b0101;
                        remaining <= remaining - 1;
                    end
                end
                4'b0110: begin
                    if(ack == 1) begin
                        state <= 4'b0000;
                        done <= 0;
                    end else begin
                        state <= 4'b0110;
                    end
                end
                default: state <= 4'b0000;
            endcase
        end
    end

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            remaining <= 4'b0000;
        end else begin
            if(counting) begin
                remaining <= delay;
            end
        end
    end

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 4'bxxxx;
            found_sequence <= 0;
        end else begin
            if(counting) begin
                count <= remaining;
            end else begin
                count <= 4'bxxxx;
                found_sequence <= 0;
            end
        end
    end

endmodule
