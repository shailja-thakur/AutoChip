module top_module (
    input clk,
    input in,
    input reset,
    output done
);

// Define states
typedef enum logic [3:0] {
    IDLE,
    START_BIT,
    RECEIVE_BITS,
    STOP_BIT
} state_t;

// Define signals
reg [3:0] state;
reg [8:0] data;
reg valid_start_bit;
reg valid_stop_bit;

// Always block for state transitions and actions
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        data <= 0;
        valid_start_bit <= 0;
        valid_stop_bit <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START_BIT;
                    data <= 0;
                    valid_start_bit <= 0;
                    valid_stop_bit <= 0;
                end
            end

            START_BIT: begin
                if (in == 1'b0) begin
                    state <= RECEIVE_BITS;
                    data <= 0;
                    valid_start_bit <= 1;
                    valid_stop_bit <= 0;
                end else begin
                    state <= IDLE;
                    data <= 0;
                    valid_start_bit <= 0;
                    valid_stop_bit <= 0;
                end
            end

            RECEIVE_BITS: begin
                data <= {in, data[8:1]};
                if (valid_start_bit && (data[0] == 1'b1)) begin
                    state <= STOP_BIT;
                    valid_stop_bit <= 0;
                end
            end

            STOP_BIT: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    valid_start_bit <= 0;
                    valid_stop_bit <= 1;
                end
            end
        endcase
    end
end

// Output done when a valid byte has been received
assign done = (state == STOP_BIT && valid_stop_bit);

endmodule
