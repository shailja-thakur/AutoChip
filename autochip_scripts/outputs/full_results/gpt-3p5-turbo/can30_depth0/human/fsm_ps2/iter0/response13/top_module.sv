module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [2:0] state;
reg [1:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        count <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    state <= 1;
                    count <= 1;
                end
            end
            1: begin
                if (count == 0 && in[3] == 1) begin
                    state <= 2;
                    count <= 1;
                end else if (count == 1) begin
                    state <= 0;
                    count <= 0;
                    done <= 1;
                end else begin
                    count <= count + 1;
                end
            end
            2: begin
                if (count == 0 && in[3] == 1) begin
                    state <= 1;
                    count <= 1;
                end else if (count == 1 && in[3] == 1) begin
                    state <= 2;
                    count <= 2;
                end else begin
                    count <= count + 1;
                end
            end
        endcase
    end
end

endmodule
