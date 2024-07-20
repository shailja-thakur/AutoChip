module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define the states
typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
} state_type;

reg [2:0] state;
reg [7:0] data_byte;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        data_byte <= 8'b0;
        done <= 0;
    end else begin
        case (state)
            IDLE:
                if (in == 1'b0) begin
                    state <= START_BIT;
                end
            START_BIT:
                if (in == 1'b0) begin
                    state <= DATA_BITS;
                    data_byte <= 8'b0;
                end else begin
                    state <= IDLE;
                end
            DATA_BITS:
                if (in == 1'b0) begin
                    data_byte <= {data_byte[6:0], in};
                end else begin
                    state <= STOP_BIT;
                end
            STOP_BIT:
                if (in == 1'b1) begin
                    state <= IDLE;
                    done <= 1;
                end
        endcase
    end
end

assign out_byte = done ? data_byte : 8'b0;

endmodule
