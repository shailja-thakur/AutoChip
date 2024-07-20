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
            0: begin // Waiting for start of message
                if (in[3]) begin
                    state <= 1;
                    count <= 1;
                end
                else begin
                    state <= 0;
                    count <= 0;
                    done <= 0;
                end
            end
            1: begin // Receiving message
                if (in[3]) begin
                    count <= count + 1;
                    if (count == 2) begin
                        state <= 2;
                        done <= 1;
                    end
                    else begin
                        state <= 1;
                    end
                end
                else begin
                    state <= 0;
                    count <= 0;
                    done <= 0;
                end
            end
            2: begin // Message received
                state <= 0;
                count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
