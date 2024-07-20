module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            0: begin // Waiting for first byte
                if (in[3]) begin
                    state <= 1;
                    count <= 1;
                end
                else begin
                    state <= 0;
                    count <= 0;
                end
                done <= 0;
            end
            1: begin // Waiting for second byte
                if (count == 1) begin
                    count <= 2;
                end
                else begin
                    state <= 2;
                    count <= 0;
                end
                done <= 0;
            end
            2: begin // Waiting for third byte
                if (count == 0) begin
                    count <= 1;
                end
                else begin
                    state <= 0;
                    count <= 0;
                    done <= 1;
                end
            end
            default: begin
                state <= 0;
                count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
