module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    // State definitions
    parameter IDLE = 2'b00;
    parameter START_BIT = 2'b01;
    parameter DATA_BIT = 2'b10;
    parameter STOP_BIT = 2'b11;
    
    // Internal signals
    reg [1:0] state;
    reg [7:0] data;
    reg [2:0] bit_count;
    reg done_reg;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data <= 8'b0;
            bit_count <= 3'b0;
            done_reg <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (in == 1'b0) begin
                        state <= START_BIT;
                        bit_count <= 3'b0;
                        data <= 8'b0;
                    end
                end
                START_BIT: begin
                    if (bit_count < 3) begin
                        state <= START_BIT;
                        bit_count <= bit_count + 1;
                    end else begin
                        state <= DATA_BIT;
                    end
                end
                DATA_BIT: begin
                    if (bit_count < 11) begin
                        state <= DATA_BIT;
                        bit_count <= bit_count + 1;
                        data <= {data[6:0], in};
                    end else begin
                        state <= STOP_BIT;
                    end
                end
                STOP_BIT: begin
                    if (bit_count < 12) begin
                        state <= STOP_BIT;
                        bit_count <= bit_count + 1;
                    end else begin
                        state <= IDLE;
                        done_reg <= 1'b1;
                    end
                end
            endcase
        end
    end

    // Output registers
    always @(posedge clk) begin
        if (reset) begin
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            out_byte <= data;
            done <= done_reg;
        end
    end

endmodule
