module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] shift_reg;
reg [2:0] count;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_reg <= 8'b0;
        count <= 3'b0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START_BIT;
                    shift_reg <= 8'b0;
                    count <= 3'b0;
                end
            end
            START_BIT: begin
                if (count == 3'b111) begin
                    state <= DATA_BITS;
                    shift_reg <= {shift_reg[6:0], in};
                    count <= 3'b0;
                end else begin
                    count <= count + 1;
                end
            end
            DATA_BITS: begin
                if (count == 3'b111) begin
                    state <= STOP_BIT;
                    shift_reg <= {shift_reg[6:0], in};
                    count <= 3'b0;
                end else begin
                    count <= count + 1;
                    shift_reg <= {shift_reg[6:0], in};
                end
            end
            STOP_BIT: begin
                if (count == 3'b000 && in == 1'b1) begin
                    state <= IDLE;
                    out_byte <= shift_reg;
                    shift_reg <= 8'b0;
                    count <= 3'b0;
                    done <= 1'b1;
                end else begin
                    count <= count + 1;
                end
            end
        endcase
    end
end

endmodule
