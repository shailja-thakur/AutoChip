module top_module (
    input clk,
    input in,
    input reset,
    output done
);

// Define state names
typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
} state_t;

// Define signals
reg [2:0] state;
reg [7:0] data;

// Synchronous reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        data <= 8'b0;
    end else begin
        case (state)
            IDLE:
                if (in == 1'b0)
                    state <= START_BIT;
            START_BIT:
                if (in == 1'b0) begin
                    state <= DATA_BITS;
                    data <= 1'b0;
                end else
                    state <= IDLE;
            DATA_BITS:
                if (in == 1'b0) begin
                    data <= {data[6:0], in};
                    if (data == 8'b11111111)
                        state <= STOP_BIT;
                end else
                    state <= IDLE;
            STOP_BIT:
                if (in == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b1;
                end
                else if (in == 1'b0)
                    state <= START_BIT;
        endcase
    end
end

endmodule
