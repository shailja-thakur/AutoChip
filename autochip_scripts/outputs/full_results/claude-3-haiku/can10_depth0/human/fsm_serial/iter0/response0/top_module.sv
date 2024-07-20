module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

localparam [2:0] IDLE = 3'b000;
localparam [2:0] START = 3'b001;
localparam [2:0] DATA = 3'b010;
localparam [2:0] STOP = 3'b011;
localparam [2:0] ERROR = 3'b100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                    data_reg <= 0;
                end
            end
            START: begin
                if (bit_count == 3'd7) begin // 8 bits received
                    state <= DATA;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                    data_reg <= {data_reg[6:0], in};
                end
            end
            DATA: begin
                if (bit_count == 3'd7) begin // 8 bits received
                    state <= STOP;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count + 1;
                    data_reg <= {data_reg[6:0], in};
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    state <= IDLE;
                    done <= 1'b1;
                end
                else begin // Stop bit not detected
                    state <= ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin // Wait for stop bit
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
