module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define states
localparam START = 3'd0;
localparam DATA  = 3'd1;
localparam STOP  = 3'd2;
localparam WAIT  = 3'd3;

reg [2:0] state;
reg [2:0] bit_count;
reg [7:0] data_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state     <= START;
        bit_count <= 0;
        data_reg  <= 0;
        out_byte  <= 0;
        done      <= 0;
    end
    else begin
        case (state)
            START: begin
                // Wait for start bit (0)
                if (in == 1'b0) begin
                    state     <= DATA;
                    bit_count <= 0;
                end
            end
            DATA: begin
                // Shift in data bits
                data_reg <= {in, data_reg[7:1]};
                bit_count <= bit_count + 1;
                if (bit_count == 3'd7) begin
                    state <= STOP;
                end
            end
            STOP: begin
                // Check for stop bit (1)
                if (in == 1'b1) begin
                    out_byte <= data_reg;
                    done <= 1'b1;
                    state <= START;
                end
                else begin
                    state <= WAIT;
                end
            end
            WAIT: begin
                // Wait for stop bit (1)
                if (in == 1'b1) begin
                    state <= START;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= START;
            end
        endcase
    end
end

endmodule
