module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

// Define states
parameter IDLE = 2'b00;
parameter START_BIT = 2'b01;
parameter DATA_BIT = 2'b10;
parameter STOP_BIT = 2'b11;

reg [1:0] state;        // Current state
reg [7:0] byte;         // Data byte
reg done_flag;          // Flag to indicate done

// Synchronous reset
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        byte <= 8'b0;
        done_flag <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START_BIT;
                    byte <= 8'b0;
                end
            end
            START_BIT: begin
                state <= DATA_BIT;
                byte <= {byte[6:0], in};
            end
            DATA_BIT: begin
                state <= DATA_BIT;
                byte <= {byte[6:0], in};
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    done_flag <= 1'b1;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

// Output
assign out_byte = done_flag ? byte : 8'b0;
assign done = done_flag;

endmodule
