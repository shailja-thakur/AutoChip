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
            0: begin // Wait for start of message
                if (in[3]) begin
                    state <= 1;
                    count <= 1;
                end
            end
            1: begin // Receive byte 2
                if (in[3]) begin
                    state <= 2;
                    count <= 2;
                end
                else begin
                    count <= count + 1;
                end
            end
            2: begin // Receive byte 3
                if (in[3]) begin
                    state <= 0;
                    count <= 0;
                end
                else begin
                    done <= 1;
                    count <= count + 1;
                    if (count == 3) begin
                        done <= 0;
                    end
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
