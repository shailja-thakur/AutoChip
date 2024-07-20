module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            0: begin // Waiting for start of message
                if (in[3]) begin
                    state <= 1;
                    byte_count <= 1;
                end
                else begin
                    byte_count <= 0;
                end
                done <= 0;
            end
            1: begin // Receiving 2nd byte
                if (byte_count == 1) begin
                    byte_count <= 2;
                end
                else if (byte_count == 2) begin
                    state <= 2;
                    byte_count <= 3;
                end
                done <= 0;
            end
            2: begin // Receiving 3rd byte
                if (byte_count == 3) begin
                    done <= 1;
                    byte_count <= 0;
                    state <= 0;
                end
                else begin
                    byte_count <= 0;
                    state <= 0;
                end
            end
            default: begin
                state <= 0;
                byte_count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
