module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define the states of the FSM
localparam WAIT_START = 0;
localparam GET_DATA = 1;
localparam VERIFY_STOP = 2;

reg [1:0] state;
reg [3:0] bit_count;
reg [7:0] data_register;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_START;
        bit_count <= 0;
        data_register <= 0;
        out_byte <= 0;
        done <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                // Wait for the start bit (0)
                if (in == 0) begin
                    state <= GET_DATA;
                    bit_count <= 0;
                    data_register <= 0;
                end
            end
            GET_DATA: begin
                // Shift in the data bits
                data_register <= {data_register[6:0], in};
                bit_count <= bit_count + 1;
                if (bit_count == 7) begin
                    state <= VERIFY_STOP;
                end
            end
            VERIFY_STOP: begin
                // Verify the stop bit (1)
                if (in == 1) begin
                    out_byte <= data_register;
                    done <= 1;
                    state <= WAIT_START;
                end else begin
                    // Wait until a stop bit is found
                    state <= WAIT_START;
                    done <= 0;
                end
            end
            default: begin
                state <= WAIT_START;
            end
        endcase
    end
end

endmodule
