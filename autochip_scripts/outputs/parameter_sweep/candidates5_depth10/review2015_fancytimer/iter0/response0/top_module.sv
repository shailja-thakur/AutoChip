module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg start_sequence;
    reg [3:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            start_sequence <= 1'b0;
            delay <= 4'b0;
            state <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'd0;
        end else begin
            case (state)
                4'b0000:
                    begin
                        if (data == 1'b1 && start_sequence == 1'b0) begin
                            start_sequence <= 1'b1;
                            state <= 4'b0001;
                        end
                    end

                4'b0001:
                    begin
                        if (data == 1'b1 && start_sequence == 1'b1) begin
                            start_sequence <= 1'b0;
                            delay <= data;
                            state <= 4'b0010;
                        end else begin
                            start_sequence <= 1'b0;
                            state <= 4'b0000;
                        end
                    end

                4'b0010:
                    begin
                        start_sequence <= 1'b0;
                        counting <= 1'b1;
                        state <= 4'b0011;
                    end

                4'b0011:
                    begin
                        counting <= 1'b1;
                        state <= 4'b0100;
                    end

                4'b0100:
                    begin
                        if (counting == 1'b1) begin
                            if (count < (delay + 1)) begin
                                count <= count + 1;
                                counting <= 1'b0;
                                state <= 4'b0011;
                            end
                        else begin
                            done <= 1'b1;
                            counting <= 1'b0;
                            state <= 4'b0101;
                        end
                    end

                4'b0101:
                    begin
                        done <= 1'b1;
                        counting <= 1'b0;
                        if (ack == 1'b1) begin
                            start_sequence <= 1'b0;
                            state <= 4'b0000;
                        end
                    end

                default:
                    begin
                        start_sequence <= 1'b0;
                        state <= 4'b0000;
                    end
            endcase
        end
    end

endmodule
