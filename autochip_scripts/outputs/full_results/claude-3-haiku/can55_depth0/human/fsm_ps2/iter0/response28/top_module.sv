module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] 
    WAIT_FIRST = 2'b00,
    WAIT_SECOND = 2'b01,
    WAIT_THIRD = 2'b10,
    DONE = 2'b11;

reg [1:0] state;
reg [1:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FIRST;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_FIRST: begin
                if (in[3]) begin
                    state <= WAIT_SECOND;
                    byte_count <= 1;
                end
            end
            WAIT_SECOND: begin
                byte_count <= byte_count + 1;
                if (byte_count == 2) begin
                    state <= WAIT_THIRD;
                end
            end
            WAIT_THIRD: begin
                byte_count <= byte_count + 1;
                if (byte_count == 3) begin
                    state <= DONE;
                    done <= 1;
                end
            end
            DONE: begin
                done <= 0;
                state <= WAIT_FIRST;
                byte_count <= 0;
            end
        endcase
    end
end

endmodule
