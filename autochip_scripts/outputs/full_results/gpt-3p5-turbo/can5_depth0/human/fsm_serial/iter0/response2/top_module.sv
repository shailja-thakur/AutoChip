module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [2:0] state;
reg start_bit;
reg [7:0] data;
reg stop_bit;
reg done_reg;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        start_bit <= 0;
        data <= 0;
        stop_bit <= 1;
        done_reg <= 0;
    end else begin
        case (state)
            IDLE: begin
                start_bit <= in;
                if (start_bit) begin
                    state <= START_BIT;
                end
            end

            START_BIT: begin
                if (!in) begin
                    state <= DATA_BITS;
                    data <= in;
                end
            end

            DATA_BITS: begin
                if (!in) begin
                    data <= {data[6:0], in};
                end

                if (!$isunknown(data[7]) && $isunknown(data[0])) begin
                    state <= STOP_BIT;
                end
            end

            STOP_BIT: begin
                stop_bit <= in;
                if (!in) begin
                    done_reg <= 1;
                    state <= IDLE;
                end
            end
        endcase
    end
end

assign done = done_reg;

endmodule
