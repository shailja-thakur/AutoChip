module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam WAIT_FOR_FIRST = 2'b00;
localparam WAIT_FOR_SECOND = 2'b01;
localparam WAIT_FOR_THIRD = 2'b10;

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_FIRST;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_FOR_FIRST: begin
                if (in[3]) begin
                    state <= WAIT_FOR_SECOND;
                    byte_count <= 1;
                end
            end
            WAIT_FOR_SECOND: begin
                byte_count <= byte_count + 1;
                if (byte_count == 2) begin
                    state <= WAIT_FOR_THIRD;
                end
            end
            WAIT_FOR_THIRD: begin
                byte_count <= byte_count + 1;
                if (byte_count == 3) begin
                    state <= WAIT_FOR_FIRST;
                    byte_count <= 0;
                    done <= 1;
                end
            end
            default: begin
                state <= WAIT_FOR_FIRST;
                byte_count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
