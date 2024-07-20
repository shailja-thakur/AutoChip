module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

localparam [2:0] 
    IDLE  = 3'b000,
    START = 3'b001,
    DATA  = 3'b010,
    STOP  = 3'b011;

reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data_reg <= 0;
        out_byte <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    state <= START;
                    bit_count <= 0;
                end
                done <= 0;
            end
            START: begin
                if (in == 1'b0) begin // Start bit still present
                    state <= DATA;
                end
                else begin // Start bit not present, restart
                    state <= IDLE;
                end
            end
            DATA: begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin // All 8 data bits received
                    state <= STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit present
                    state <= IDLE;
                    out_byte <= data_reg;
                    done <= 1'b1;
                end
                else begin // Stop bit not present, restart
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
