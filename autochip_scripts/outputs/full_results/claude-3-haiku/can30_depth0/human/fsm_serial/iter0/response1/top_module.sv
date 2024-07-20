module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// Define states
localparam [1:0] IDLE = 2'b00, RECEIVING = 2'b01, WAIT_STOP = 2'b10;

// Internal registers
reg [2:0] bit_count;
reg [7:0] data;

// State register
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        data <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                // Wait for start bit (0)
                if (in == 0) begin
                    state <= RECEIVING;
                    bit_count <= 0;
                    data <= 0;
                end
            end
            RECEIVING: begin
                // Shift in data bits
                data <= {data[6:0], in};
                bit_count <= bit_count + 1;

                // Check if all 8 data bits have been received
                if (bit_count == 7) begin
                    state <= WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                // Check for stop bit (1)
                if (in == 1) begin
                    done <= 1;
                    state <= IDLE;
                end else begin
                    // Wait for stop bit
                    state <= WAIT_STOP;
                end
            end
        endcase
    end
end

endmodule
