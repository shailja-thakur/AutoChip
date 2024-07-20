module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state;
    reg [2:0] bit_count;
    reg [7:0] data_byte;

    // State Encoding
    localparam IDLE = 4'd0,
               START_BIT = 4'd1,
               DATA_BITS = 4'd2,
               STOP_BIT = 4'd3,
               DONE = 4'd4,
               ERROR = 4'd5;

    // State Transition and Output Logic
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            out_byte <= 8'd0;
            data_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            case(state)
                IDLE: begin
                    done <= 1'b0;
                    if(in == 1'b0) begin
                        state <= START_BIT;
                    end
                end
                START_BIT: begin
                    if(in == 1'b0) begin
                        state <= DATA_BITS;
                        bit_count <= 3'd0;
                    end else begin
                        state <= IDLE;
                    end
                end
                DATA_BITS: begin
                    data_byte[bit_count] <= in;
                    bit_count <= bit_count + 1;
                    if(bit_count == 3'd7) begin
                        state <= STOP_BIT;
                    end
                end
                STOP_BIT: begin
                    if(in == 1'b1) begin
                        out_byte <= data_byte;
                        done <= 1'b1;
                        state <= DONE;
                    end else begin
                        state <= ERROR;
                    end
                end
                DONE: begin
                    if(in == 1'b1) begin
                        state <= IDLE;
                    end else begin
                        done <= 1'b0;
                        state <= START_BIT;
                    end
                end
                ERROR: begin
                    if(in == 1'b1) begin
                        state <= IDLE;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule
