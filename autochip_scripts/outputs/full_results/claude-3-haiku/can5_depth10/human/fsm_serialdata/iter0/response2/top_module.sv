module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [2:0] state;
    reg [3:0] bit_count;
    reg [7:0] data_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= `IDLE;
            bit_count <= 0;
            data_reg <= 0;
            done <= 0;
            out_byte <= 0;
        end
        else begin
            case (state)
                `IDLE: begin
                    if (in == 0) begin // Start bit detected
                        state <= `START;
                        bit_count <= 0;
                    end
                end

                `START: begin
                    if (bit_count == 4'd9) begin // 1 start bit + 8 data bits
                        if (in == 1) begin // Stop bit detected
                            state <= `STOP;
                            out_byte <= data_reg;
                            done <= 1;
                        end
                        else begin // Stop bit not detected
                            state <= `IDLE;
                            done <= 0;
                        end
                    end
                    else begin
                        bit_count <= bit_count + 1;
                        data_reg <= {data_reg[6:0], in};
                    end
                end

                `STOP: begin
                    if (in == 1) begin // Stop bit verified
                        state <= `IDLE;
                        done <= 0;
                    end
                end

                default: begin
                    state <= `IDLE;
                    bit_count <= 0;
                    data_reg <= 0;
                    done <= 0;
                    out_byte <= 0;
                end
            endcase
        end
    end

endmodule
