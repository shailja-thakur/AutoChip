module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

reg [2:0] state;
reg [7:0] data_reg;
reg [7:0] out_reg;
reg valid_start_bit;
wire valid_stop_bit;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        data_reg <= 8'b0;
        out_reg <= 8'b0;
        valid_start_bit <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START_BIT;
                    valid_start_bit <= 1;
                end
            end
            START_BIT: begin
                if (in == 1'b1) begin
                    state <= DATA_BITS;
                    data_reg <= 8'b0;
                end
            end
            DATA_BITS: begin
                if (in == 1'b0 || in == 1'b1) begin
                    data_reg <= {data_reg[6:0], in};
                    if (data_reg[7] == 1'b1)
                        state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    out_reg <= data_reg;
                    state <= IDLE;
                    done <= 1;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

always @(posedge clk) begin
    if (reset) begin
        out_byte <= 8'b0;
    end else begin
        out_byte <= out_reg;
    end
end
endmodule
