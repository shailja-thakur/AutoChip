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
    end else begin
        case (state)
            0: begin // Searching for first byte
                if (in[3]) begin
                    state <= 1;
                    count <= 1;
                end
            end
            1: begin // Receiving second byte
                if (count == 1) begin
                    count <= 2;
                end else begin
                    state <= 2;
                    count <= 0;
                end
            end
            2: begin // Receiving third byte
                if (count == 0) begin
                    done <= 1;
                end else begin
                    count <= 0;
                end
            end
        endcase
    end
end

endmodule
