module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] WAIT_START = 2'b00, 
                 WAIT_BYTE2 = 2'b01, 
                 WAIT_BYTE3 = 2'b10;

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (in[3]) begin
                    state <= WAIT_BYTE2;
                    byte_count <= 1;
                end
                else begin
                    state <= WAIT_START;
                    byte_count <= 0;
                end
                done <= 0;
            end
            WAIT_BYTE2: begin
                if (byte_count == 1) begin
                    state <= WAIT_BYTE3;
                    byte_count <= 2;
                end
                else begin
                    state <= WAIT_START;
                    byte_count <= 0;
                end
                done <= 0;
            end
            WAIT_BYTE3: begin
                if (byte_count == 2) begin
                    state <= WAIT_START;
                    byte_count <= 0;
                    done <= 1;
                end
                else begin
                    state <= WAIT_START;
                    byte_count <= 0;
                    done <= 0;
                end
            end
            default: begin
                state <= WAIT_START;
                byte_count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
