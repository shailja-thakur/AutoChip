module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    reg [3:0] state;
    reg [7:0] data_reg;
    reg [2:0] bit_count;

    localparam IDLE = 4'd0;
    localparam START = 4'd1;
    localparam DATA = 4'd2;
    localparam STOP = 4'd3;
    localparam DONE = 4'd4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'b0;
            data_reg <= 8'b0;
            bit_count <= 3'b0;
            done <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0) begin // Start bit detected
                        state <= START;
                    end
                end
                START: begin
                    state <= DATA;
                    bit_count <= 3'd0;
                end
                DATA: begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                    if (bit_count == 3'd7) begin
                        state <= STOP;
                    end
                end
                STOP: begin
                    if (in == 1'b1) begin // Stop bit detected
                        out_byte <= data_reg;
                        done <= 1'b1;
                        state <= DONE;
                    end
                    else begin
                        state <= IDLE; // Stop bit error, go to IDLE
                    end
                end
                DONE: begin
                    done <= 1'b0;
                    state <= IDLE;
                end
                default: begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            endcase
        end
    end
endmodule
