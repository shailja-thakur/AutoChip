module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// Internal signals
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        // Reset the internal signals
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        state <= 0;
        out_bytes <= 0;
        done <= 0;
    end else begin
        // Non-reset behavior
        case (state)
            0: begin
                // Discard bytes until in[3] = 1
                if (in[3] == 1) begin
                    byte1 <= in;
                    state <= 1;
                end
            end
            1: begin
                byte2 <= in;
                state <= 2;
            end
            2: begin
                byte3 <= in;
                out_bytes <= {byte1, byte2, byte3};
                done <= 1;
                state <= 0;
            end
        endcase
    end
end

endmodule
