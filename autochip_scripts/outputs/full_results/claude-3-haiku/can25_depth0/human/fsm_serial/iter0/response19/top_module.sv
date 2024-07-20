module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

localparam IDLE = 3'b000;
localparam START = 3'b001;
localparam DATA = 3'b010;
localparam STOP = 3'b011;
localparam ERROR = 3'b100;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    state <= START;
                    bit_count <= 0;
                end
            end
            START: begin
                if (bit_count == 0 && in == 0) begin
                    bit_count <= 1;
                end
                else if (bit_count == 1 && in == 0) begin
                    state <= DATA;
                    bit_count <= 0;
                end
                else begin
                    state <= ERROR;
                    bit_count <= 0;
                end
            end
            DATA: begin
                if (bit_count < 8) begin
                    data <= {data[6:0], in};
                    bit_count <= bit_count + 1;
                end
                else begin
                    state <= STOP;
                    bit_count <= 0;
                end
            end
            STOP: begin
                if (bit_count == 0 && in == 1) begin
                    bit_count <= 1;
                    done <= 1;
                end
                else if (bit_count == 1 && in == 1) begin
                    state <= IDLE;
                    bit_count <= 0;
                    done <= 0;
                end
                else begin
                    state <= ERROR;
                    bit_count <= 0;
                    done <= 0;
                end
            end
            ERROR: begin
                if (in == 1) begin
                    state <= IDLE;
                    bit_count <= 0;
                end
            end
        endcase
    end
end

endmodule
