module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Module Implementation

reg [2:0] state;
reg [7:0] byte;
reg start_bit;
reg stop_bit;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        byte <= 0;
        start_bit <= 0;
        stop_bit <= 0;
        out_byte <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // Idle state waiting for start bit
                if (in == 0) begin
                    start_bit <= 1;
                    state <= 1;
                end
            end
            1: begin // Receiving data bits
                byte <= {in, byte[7:1]};
                if (start_bit) begin
                    state <= 2;
                end else begin
                    state <= 1;
                end
            end
            2: begin // Expecting stop bit
                stop_bit <= in;
                if (stop_bit) begin
                    out_byte <= byte;
                    done <= 1;
                    state <= 0;
                end
            end
        endcase
    end
end

endmodule
