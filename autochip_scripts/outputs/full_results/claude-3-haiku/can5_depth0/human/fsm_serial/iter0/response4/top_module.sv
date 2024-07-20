module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

// Define the states of the FSM
localparam [2:0] 
    STATE_WAIT_START = 3'd0,
    STATE_READ_DATA  = 3'd1,
    STATE_READ_STOP  = 3'd2,
    STATE_ERROR     = 3'd3;

// Internal registers
reg [2:0] state;
reg [3:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_START;
        bit_count <= 0;
        data_reg <= 0;
        done <= 0;
    end
    else begin
        case (state)
            STATE_WAIT_START: begin
                // Wait for the start bit (0)
                if (in == 1'b0) begin
                    state <= STATE_READ_DATA;
                    bit_count <= 0;
                end
            end
            
            STATE_READ_DATA: begin
                // Read the 8 data bits
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin
                    state <= STATE_READ_STOP;
                end
            end
            
            STATE_READ_STOP: begin
                // Check the stop bit (1)
                if (in == 1'b1) begin
                    done <= 1'b1;
                    state <= STATE_WAIT_START;
                end
                else begin
                    // Incorrect stop bit, wait for next start bit
                    state <= STATE_ERROR;
                end
            end
            
            STATE_ERROR: begin
                // Wait for the next start bit
                if (in == 1'b0) begin
                    state <= STATE_READ_DATA;
                    bit_count <= 0;
                    done <= 1'b0;
                end
            end
            
            default: begin
                state <= STATE_WAIT_START;
            end
        endcase
    end
end

endmodule
