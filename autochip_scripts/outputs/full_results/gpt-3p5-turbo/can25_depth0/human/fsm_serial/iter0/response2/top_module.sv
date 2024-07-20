module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [3:0] state;
reg [7:0] data;
reg [2:0] bit_count;

parameter IDLE = 4'd0;
parameter START_BIT = 4'd1;
parameter DATA_BITS = 4'd2;
parameter STOP_BIT = 4'd3;
parameter BYTE_RECEIVED = 4'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data <= 0;
        done <= 0;
    end else begin
        case(state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START_BIT;
                    bit_count <= 0;
                    data <= 0;
                end
            end

            START_BIT: begin
                if (bit_count < 8) begin
                    data <= {in, data[7:1]};
                    bit_count <= bit_count + 1;
                end else if (bit_count == 8) begin
                    state <= STOP_BIT;
                    bit_count <= bit_count + 1;
                end
            end

            DATA_BITS: begin
                if (bit_count < 8) begin
                    data <= {in, data[7:1]};
                    bit_count <= bit_count + 1;
                end else if (bit_count == 8) begin
                    state <= STOP_BIT;
                    bit_count <= bit_count + 1;
                end
            end

            STOP_BIT: begin
                if (in == 1'b1) begin
                    state <= BYTE_RECEIVED;
                    bit_count <= 0;
                end
            end

            BYTE_RECEIVED: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    done <= 1;
                end
            end
        endcase
    end
end

endmodule
