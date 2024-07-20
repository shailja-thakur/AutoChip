module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam IDLE = 3'b000;
localparam START = 3'b001;
localparam DATA = 3'b010;
localparam STOP = 3'b011;
localparam ERR = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_register;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_register <= 0;
        done <= 0;
        out_byte <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 4'd9) begin
                    if (in == 1'b1) begin
                        state <= DATA;
                        bit_count <= 0;
                    end else begin
                        state <= ERR;
                    end
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            DATA: begin
                if (bit_count == 4'd8) begin
                    data_register <= {in, data_register[7:1]};
                    state <= STOP;
                    bit_count <= 0;
                end else begin
                    data_register <= {in, data_register[7:1]};
                    bit_count <= bit_count + 1;
                end
            end
            STOP: begin
                if (bit_count == 4'd1) begin
                    if (in == 1'b1) begin
                        out_byte <= data_register;
                        done <= 1'b1;
                        state <= IDLE;
                    end else begin
                        state <= ERR;
                    end
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
            ERR: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
