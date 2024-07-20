module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state;
    reg [3:0] bit_cnt;
    reg [7:0] data_byte; 

    localparam IDLE = 4'b0000,
               START = 4'b0001,
               DATA = 4'b0010,
               STOP = 4'b0011;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_cnt <= 4'b0;
            data_byte <= 8'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0)  // Detect start bit
                        state <= START;
                end
                
                START: begin
                    if (in == 1'b0) begin  // Confirm it is still start bit
                        bit_cnt <= 4'b0;
                        state <= DATA;
                    end else
                        state <= IDLE;
                end
                
                DATA: begin
                    data_byte[bit_cnt] <= in;
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == 4'd7)
                        state <= STOP;
                end
                
                STOP: begin
                    if (in == 1'b1) begin  // Check stop bit
                        out_byte <= data_byte;
                        done <= 1'b1;
                    end
                    state <= IDLE;
                end
                
                default: state <= IDLE;
            endcase
        end
    end

endmodule
